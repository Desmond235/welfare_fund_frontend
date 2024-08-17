import 'dart:convert';

import 'package:church_clique/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

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
        "userID": userId ?? null,
        "username": username,
        "password": password,
      });

      final serverUrl = "http://10.0.2.2:3000/api/v1/";

      final response = await http.post(Uri.parse('${serverUrl}login'),
          headers: headers, body: body);

      getResponse(response);

      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final  token = data["token"];
        // /DateTime expirationData = JwtDecoder.getExpirationDate(token);
        final decodedToken = JwtDecoder.decode(token);
        final userId= decodedToken["id"];

        final prefs = await sharedPrefs;
        prefs.setInt('userId',userId);
        print(userId);
        
      } else {
        throw Exception('Invalid response');
      }
    } on Exception {
      throw Exception('An error occurred');
    }
  }
}




