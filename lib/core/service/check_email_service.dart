import 'dart:convert';

import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/core/service/http_service.dart';
import 'package:church_clique/core/service/send_otp.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CheckEmailService {
  static void sendOtp( String email, BuildContext context) async{
    final prefs = await sharedPrefs;
    prefs.setString('email', email);
    if(!context.mounted) return;
    SendOtpResponse.post(email, context);
  }
  static void post(String email, int id, BuildContext context) async {
    const baseUrl = 'http://10.0.2.2:3000/api/v1/';
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}check-email/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email}),
      );

      if(!context.mounted) return;
      if(response.statusCode == 200){
       sendOtp(email, context);
      }else{
        snackBar(context, 'Please enter the email address you used to sign up');
      }
    } on Exception catch (e) {
      snackBar(context, e.toString());
    }
  }
}
