import 'dart:convert';

import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/core/service/http_service.dart';
import 'package:church_clique/features/form/provider/form_state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class MembershipService {
  static Future<int?> post(
      Map<String, dynamic> data, BuildContext context) async {
    try {
      const serverEndpoint = 'http://10.0.2.2:3000/api/v1/';

      final response =
          await http.post(Uri.parse('${serverEndpoint}send-details'),
              headers: {
                'Content-Type': 'application/json',
              
              },
              body: jsonEncode(data));

        if (!context.mounted) return null;      

      if (response.statusCode == 200) {
        // snackBar(context, 'Records sent successfully.');
        if(context.mounted){
          Navigator.of(context).pushReplacementNamed('auth');
        }
        context.read<MemFormState>().setFormState(true);
        
        final Map<String, dynamic> data = jsonDecode(response.body);
        final memberId = data['id'] as int?;
        final prefs = await sharedPrefs;
         prefs.setInt('memberId', memberId ?? 0);
         
        return memberId;
      } else {
        throw Exception('Failed to send records');
      }
    } on Exception{
    
      if(context.mounted){
        snackBar(context, "Failed to send records, please try again later.");
      }
      
      return null;
    }
  }

  // static Future<List<MembershipModel>> getMemberships() async {
  //   final serverEndpoint = 'http://10.0.2.2:3000/api/v1/';

  //   final response = await http.get(Uri.parse('${serverEndpoint}get-details'));

  //   if (response.statusCode == 200) {
  //     final List<dynamic> membership = jsonDecode(response.body);
  //     final List<MembershipModel> membershipData =
  //         membership.map((json) => MembershipModel.fromJson(json)).toList();
  //     return membershipData;
  //   } else {
  //     throw Exception("Failed to fetch details");
  //   }
  // }
}
