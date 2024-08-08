import 'dart:convert';

import 'package:church_clique/core/service/http_service.dart';
import 'package:church_clique/features/auth/views/auth.dart';
import 'package:church_clique/features/form/models/membership_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MembershipService {

  static  post(Map<String, dynamic> data, BuildContext context) async {
    try {
      final serverEndpoint = 'http://10.0.2.2:6000/api/v1/';

      final response = await http.post(
          Uri.parse('${serverEndpoint}send-details'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data));

      if (response.statusCode == 200) {
        snackBar(context, 'Records sent successfully.');
        Navigator.of(context).pushReplacementNamed('main');

        final Map<String, dynamic> data = jsonDecode(response.body);
        return MembershipModel.fromJson(data);
      }
      if (response.statusCode == 422) {
        throw Exception('dddddddd');
      }
    } catch (e) {

      print(e.toString());
      snackBar(context, "Failed to send records, please try again later.");
    }
  }

  static Future<List<MembershipModel>> getMemberships() async {
    final serverEndpoint = 'http://10.0.2.2:3000/api/v1/';

    final response = await http.get(Uri.parse('${serverEndpoint}get-details'));
    
    if (response.statusCode == 200) {
      final List<dynamic> membership = jsonDecode(response.body);
      final List<MembershipModel> membershipData =
          membership.map((json) => MembershipModel.fromJson(json)).toList();
      return membershipData;
    } else {
      throw Exception("Failed to fetch details");
    }
  }
}
