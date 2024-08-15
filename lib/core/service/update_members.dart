import 'dart:convert';

import 'package:http/http.dart' as http;

class UpdateMembersResponse {
  static Future<void> updateMembers(
    int id,
    Map<String, dynamic> data,
    dynamic snackBar,
  ) async {
    final BASE_URL = "http://10.0.2.2:3000/api/v1/update-members/";
    try {
      final response = await http.post(Uri.parse('${BASE_URL}/$id'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data));
      if (response.statusCode != 200) {
        snackBar;
      }
    } on Exception catch (e) {
      print('An error occurred while updating details: $e');
    }
  }
}
