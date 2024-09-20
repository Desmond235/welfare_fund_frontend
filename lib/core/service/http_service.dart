import 'dart:convert';
import 'dart:io';
import 'package:church_clique/core/service/upload_image.dart';
import 'package:church_clique/features/auth/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

void snackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(milliseconds: 3000),
    ),
  );
}

class Http {
  static  post(
    Map<String, dynamic> data,
    BuildContext context,
    void Function(http.Response response) getResponse
  ) async {
    try {
      final response = await http.post(
        Uri.parse(dotenv.env["URL"]!),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      getResponse(response);
      if (!context.mounted) return null;

      if (response.statusCode == 409) {
        if (context.mounted) {
          return snackBar(context, 'Email already in use');
          
        }
      } else if (response.statusCode == 400) {
        if (context.mounted) {
          return snackBar(context, 'username already in use');
          
        }
      }
    } on Exception {
      if (context.mounted) {
        snackBar(context, "An error occurred!");
      }
    }

    return null;
  }
}
