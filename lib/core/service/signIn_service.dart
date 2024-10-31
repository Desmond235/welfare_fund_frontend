import 'dart:convert';

import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/core/service/http_service.dart';
import 'package:church_clique/features/auth/providers/sign_provider.dart';
import 'package:church_clique/features/form/provider/form_state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

class SigninService {
  static login(
    String username,
    String password,
    int? userId,
    BuildContext context,
    void Function(http.Response response) getResponse,
  ) async {
      
    try {
      var headers = {
        "Content-Type": "application/json",
      };

      Object? body = jsonEncode({
        "username": username,
        "password": password,
      });

      const serverUrl = "http://10.0.2.2:3000/api/v1/";

      final response = await http.post(Uri.parse('${serverUrl}login'),
          headers: headers, body: body);

      getResponse(response);

      var data = jsonDecode(response.body);

   

      if (response.statusCode == 200) {
        final  token = data["token"];
        // /DateTime expirationData = JwtDecoder.getExpirationDate(token);
        final decodedToken = JwtDecoder.decode(token);
        final userId= decodedToken["id"];
        print(userId);

        final prefs = await sharedPrefs;
        prefs.setInt('signinId', userId);

           if (!context.mounted) return;

         Provider.of<SignInProvider>(context, listen: false).setSignIn(true);
        Provider.of<MemFormState>(context, listen: false).setUserId(userId);
        context.read<SignInProvider>().setUserId(userId);
      }    else {
        throw Exception('Invalid response');
      }
    } on Exception {
      if(context.mounted){
          snackBar(context, 'Username or password incorrect');
      }
       }
  }
}




