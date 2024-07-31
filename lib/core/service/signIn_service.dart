import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SigninService {
  static post(Map<String, dynamic> data) async {
    final serverUrl = "http://10.0.2.2:6000/api/v1/";
    final response = await http.post(
      Uri.parse('${serverUrl}login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data)
    );

    if(response.statusCode == 401){
      
    }
  }
}
