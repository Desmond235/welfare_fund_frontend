import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<void> uploadFile(String? filePath, String serverUrl) async { 
 
  File file = File(filePath!);  
  var request = http.MultipartRequest('POST', Uri.parse(serverUrl));  
  var pic = await http.MultipartFile.fromPath('file', file.path);  
  request.files.add(pic);  
  
  var response = await request.send();  
  if (response.statusCode == 200) {  
    print('File uploaded successfully');  
  } else {  
    print('File upload failed');  
  }  
}

