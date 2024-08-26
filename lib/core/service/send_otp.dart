import 'dart:convert';
import 'dart:nativewrappers/_internal/vm/lib/developer.dart';

import 'package:church_clique/core/service/http_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;

class SendOtpResponse {
  static post(String email, BuildContext context) async {
    try {
      const otpUrl = 'http://10.0.2.2:3000/api/v1/';

      final data = {"email": email};

      final response = await http.post(
        Uri.parse('${otpUrl}send-email'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data)
      );

      if(!context.mounted){
        return;
      }
      if(response.statusCode == 200){
        print('otp sent successfully');
      }
      else{
        print('Could not sent otp');
      }
    } on Exception catch (e) {
      print('An error occurred while sending otp: $e');
    }
  }
}
