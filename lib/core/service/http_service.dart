import 'dart:convert';
import 'dart:io';

import 'package:church_clique/core/service/upload_image.dart';
import 'package:church_clique/features/auth/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

snackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(milliseconds: 3000),
    ),
  );
}

class Http {
  static post(
    Map<String, dynamic> data,
    BuildContext context,
    {required File file}
  ) async {
    try {

      final response = await http.post(
        Uri.parse(dotenv.env["URL"]!),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // get items from the server
        final dynamic data = jsonDecode(response.body);

        final User user = User.fromJson(data);
        Navigator.of(context).pushReplacementNamed('main');
        return user;
      }

      if (response.statusCode == 409) {
        snackBar(
            context, 'Email or username already in use, use a different one');
      }

      if (response.statusCode == 400) {
        snackBar(context, "Something went wrong");
      }
    } on Exception {
      snackBar(context, "An error occurred while logging in!");
    }
    uploadImage(file: file, context: context);
  }
}
