import 'dart:convert';

import 'package:church_clique/core/config/environ.dart';
import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/features/payment/data/data.dart';
import 'package:church_clique/features/payment/transaction/models/paystack_auth_response.dart';
import 'package:church_clique/features/payment/views/main_payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class PaymentService {
  static Future<void> sendPayment({
    required String amount,
    required String email,
    required String currency,
    
  }) async {
    http.Response? response;
    try {
      final paymentEndpoint = 'http://10.0.2.2:3000/api/v1/receive-payment';
      response = await http.post(Uri.parse(paymentEndpoint),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${EnvironConfig.secretKey}',
          },
          body: jsonEncode({
            "amount": amount,
            "email": email,
            "currency": currency,
          }));
    } on Exception catch (e) {
       print(e.toString());
    }

    
      if (response!.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        final authUrl = responseData['authorization_url'];
          final prefs = await sharedPrefs;
          prefs.setString('authUrl', authUrl);
      } else{
        throw Exception('Failed to send payment');
      }
    
  }
}
