import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void snackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
  ));
}

class SigninService {
  static post(Map<String, dynamic> data, BuildContext context,
      void Function(http.Response response) getResponse) async {
    try {
      final serverUrl = "http://10.0.2.2:6000/api/v1/";
      final response = await http.post(Uri.parse('${serverUrl}login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data));

      if (response.statusCode == 200) {
        Navigator.of(context).pushReplacementNamed('main');
      }
      if (response.statusCode == 401) {
        print('not Successful');
        snackBar(context, "Username or password is incorrect");
      }
      if (response.statusCode == 400) {
        snackBar(context, 'Something went wrong. Please try again');
      }
      getResponse(response);
    } on Exception {
      snackBar(context, "An error occurred while logging in!");
    }
  }
}
