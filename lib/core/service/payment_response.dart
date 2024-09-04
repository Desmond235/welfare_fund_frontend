import 'dart:convert';

import 'package:church_clique/core/config/environ.dart';
import 'package:church_clique/core/service/http_service.dart';
import 'package:church_clique/features/payment/model/payment_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaymentResponse {
  static Future<PaymentModel> makePayment({
    required String amount,
    required String email,
    required String currency,
    required BuildContext context,
    void Function(http.Response response)? getResponse,
  }) async {
    http.Response? response;

    try {
      const paymentEndpoint = 'http://10.0.2.2:3000/api/v1/receive-payment';
      response = await http.post(
        Uri.parse(paymentEndpoint),
        headers: {
          'Content-Type': 'Application/json',
          'Authorization': 'Bearer ${EnvironConfig.secretKey}',
        },
        body: jsonEncode(
          {"amount": amount, "email": email, "currency": currency},
        ),
      );

      getResponse!(response);
    } catch (e) {
      if (context.mounted) {
        snackBar(context, "An error occurred while initializing payment");
      }
    }

    if (response!.statusCode == 200) {
      final paymentResponseJson = jsonDecode(response.body);
      return PaymentModel.fromJson(paymentResponseJson);
    } else {
      if (context.mounted) {
        snackBar(context, 'Failed to make payment');
      }
      return PaymentModel(reference: '', authorizationUrl: '');
    }
  }
}
