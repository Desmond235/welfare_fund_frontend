
import 'package:church_clique/core/service/http_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VerifyOtpResponse {
  static post(String otp, BuildContext context) async {
    try {
      const verifyOtpUrl = 'http://10.0.2.2:3000/api/v1/';
      final response = await http.post(
        Uri.parse('${verifyOtpUrl}verify-email'),

        body: {'otp': otp},
      );
      if(response.statusCode == 200){
        print('otp verified successfully');
      }
      else{
        if(context.mounted){
          snackBar(context, 'otp invalid or expired');
        }
        return;
      }
    } on Exception catch (e) {
      print('An error occurred while verifying otp: $e');
    }
  }
}
