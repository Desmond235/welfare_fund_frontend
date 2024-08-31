// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:church_clique/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> uploadImage({required File file, required BuildContext context}) async { 
 const severUrl = 'http://10.0.2.2:3000/api/v1/';
   
  var request = http.MultipartRequest('POST', Uri.parse(
    '${severUrl}send-image',
  ));  


  var pic = await http.MultipartFile.fromPath('image', file.path);  
  request.files.add(pic);  
  
  var response = await request.send(); 

  if (response.statusCode == 200) {  

    var responseData = await http.Response.fromStream(response);
    var jsonResponse = jsonDecode(responseData.body);
    final String imagePath = jsonResponse['imagePath'];

    if(!context.mounted) return;

    if(context.mounted) {
      final prefs = await sharedPrefs;
      prefs.setString('imagePath', imagePath );
      // context.read<ImagePathProvider>().setImagePath(imagePath);

    }
    
    
    print(imagePath);
    print('come to me');
    print('File uploaded successfully'); 

  } else {  
    print('File upload failed');  
  }
}

