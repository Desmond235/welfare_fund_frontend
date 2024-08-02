import 'dart:convert';

import 'package:church_clique/core/service/http_service.dart';
import 'package:church_clique/features/form/models/membership_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MembershipService {
  static post(Map<String, dynamic> data, BuildContext context) async {
    try {
      final serverEndpoint = 'http://10.0.2.2:6000/api/v1/';
      final response = await http.post(
        Uri.parse('${serverEndpoint}send-details'),
        headers: {'ContentType': 'application/json'},
        body: jsonEncode(data)
      );
      if(response.statusCode == 200){
         snackBar(context, 'Records sent successfully.');
         Future.delayed(const Duration(milliseconds: 100));
         Navigator.of(context).pushNamed('auth');
        final Map<String, dynamic> data = jsonDecode(response.body);
        final MembershipModel membership = MembershipModel.fromJson(data);
        return membership;
      }
      if(response.statusCode == 422){
        throw Exception('dddddddd');
      }
    } on Exception {
      snackBar(context, "Failed to send records, please try again later.");
    }
  }
}