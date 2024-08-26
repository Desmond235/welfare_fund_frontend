import 'dart:convert';

import 'package:church_clique/features/auth/models/change_password_model.dart';
import 'package:http/http.dart' as http;

class ChangePasswordService {
  static Future<ChangePasswordModel> post(String username, String password) async {
    const url = 'http://10.0.2.2:3000/api/v1/change-password';

    final response = await http.post(
      Uri.parse(url),

      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"username": username, "password": password})
    );
     
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return ChangePasswordModel.fromJson(jsonResponse);
    }else{
      throw Exception('Failed to change password');
    }
  }
}
