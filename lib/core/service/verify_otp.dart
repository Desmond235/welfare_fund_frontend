
import 'package:church_clique/core/service/http_service.dart';
import 'package:church_clique/features/auth/providers/change_password_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class VerifyOtpResponse {
  static post(String otp, BuildContext context) async {
    try {
      final provider = context.read<ChangePasswordProvider>();
      const verifyOtpUrl = 'http://10.0.2.2:3000/api/v1/';
      final response = await http.post(
        Uri.parse('${verifyOtpUrl}verify-email'),

        body: {'otp': otp},
      );
      if(response.statusCode == 200){
        if(!context.mounted) return ;
        if(provider.isForgetPassword){
          Navigator.of(context).pushNamed('password');
        }else{
          Navigator.of(context).pushNamed('auth');
        }
      }
      else{
        if(context.mounted){
          snackBar(context, 'otp invalid or expired');
        }
        return;
      }
    } on Exception catch (e) {
      snackBar(context,'An error occurred while verifying otp: $e');
    }
  }
}
