import 'dart:convert';

import 'package:church_clique/features/auth/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

snackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

class Http {
  static post(Map<String, dynamic> data, BuildContext context) async {
    final response = await http.post(
      Uri.parse(dotenv.env["URL"]!),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    if (response.statusCode == 409) {
      snackBar(
          context, 'Email or username already in use, use a different one');
    }
  }

  static Future<void> uploadImage(String imagePath, String url) async {}
}
