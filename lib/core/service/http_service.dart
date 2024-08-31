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
  static Future<User?> post(Map<String, dynamic> data, BuildContext context,
      {required File? file}) async {
    if (file == null) {
      snackBar(context, 'Please pick an image');
      return null;
    }

    try {
      final response = await http.post(
        Uri.parse(dotenv.env["URL"]!),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (!context.mounted) return null;

      if (response.statusCode == 200) {
        // Navigator.of(context).pushReplacementNamed('otp');

        final dynamic data = jsonDecode(response.body);
        final User user = User.fromJson(data);

      uploadImage(file: file, context: context);
        
        return user;
      }
      
      if (response.statusCode == 409) {
        if (context.mounted) {
          snackBar(
              context, 'Email already in use');
        }
      } else if (response.statusCode == 400) {
        if (context.mounted) {
          snackBar(context, 'username already in use');
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
