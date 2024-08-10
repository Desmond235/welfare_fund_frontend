import 'dart:convert';
import 'dart:io';
import 'package:church_clique/features/settings/providers/image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

Future<void> uploadImage({required File file, required BuildContext context}) async { 
 final SEVER_URL = 'http://10.0.2.2:3000/api/v1/';
   
  var request = http.MultipartRequest('POST', Uri.parse(
    '${SEVER_URL}send-image',
  ));  


  var pic = await http.MultipartFile.fromPath('image', file.path);  
  request.files.add(pic);  
  
  var response = await request.send(); 

  if (response.statusCode == 200) {  

    var responseData = await http.Response.fromStream(response);
    var jsonResponse = jsonDecode(responseData.body);
    final String imagePath = jsonResponse['imagePath'];

    context.read<ImagePathProvider>().setImagePath(imagePath);
    
    print(imagePath);
    print('File uploaded successfully'); 

  } else {  
    print('File upload failed');  
  }
}

