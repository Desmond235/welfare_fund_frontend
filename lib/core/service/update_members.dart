import 'dart:convert';

import 'package:church_clique/core/service/http_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateMembersResponse {
  static Future<void> updateMembers(
    int id,
    Map<String, dynamic> data,
    BuildContext context,
  ) async {
    final BASE_URL = "http://10.0.2.2:3000/api/v1/update-members/$id";
    try {
      final response = await http.post(Uri.parse(BASE_URL),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data));
      //  if(response.statusCode == 200){
      //   snackBar(context, "Records updated successfully.");
      //  }   
      if (response.statusCode != 200) {
        snackBar(context, 'Failed to update records');
        print('failed to update records');
      }
    } on Exception catch (e) {
      print('An error occurred while updating details: $e');
    }
  }
}
