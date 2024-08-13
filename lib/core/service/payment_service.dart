import 'dart:convert';

import 'package:church_clique/core/config/environ.dart';
import 'package:church_clique/core/service/verify_payment_service.dart';
import 'package:church_clique/features/payment/data/data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class PaymentService {
  static Future<void> sendPayment(
    BuildContext context, {
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

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        final authUrl = responseData['authorization_url'];
        final reference = responseData['reference'];

        if (authUrl != null && reference != null) {
          Provider.of<AuthorizationUrl>(context, listen: false).authUrl(authUrl);
          Provider.of<AuthorizationUrl>(context, listen: false).setReference(reference);

          // verifyPayment(reference: reference);

          print("Authorization URL: $authUrl");
          print("Reference: $reference");
        } else {
          print("Authorization URL or Reference is null.");
        }
      } else {
        print("Failed to send payment. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Exception occurred: $e");
    }
  }
}


// ShowDialogBox(BuildContext context) {
//   showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           content: Lottie.asset(
//             'assets/no_internet.json',
//             width: 200,
//             height: 200,
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text('Ok'),
//             ),
//           ],
//         );
//       });
// }
