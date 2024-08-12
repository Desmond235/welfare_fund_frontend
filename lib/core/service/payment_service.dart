import 'dart:convert';

import 'package:church_clique/core/components/dialog_box.dart';
import 'package:church_clique/core/config/environ.dart';
import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/core/service/http_service.dart';
import 'package:church_clique/core/service/verify_payment_service.dart';
import 'package:church_clique/features/payment/data/data.dart';
import 'package:church_clique/features/payment/transaction/models/paystack_auth_response.dart';
import 'package:church_clique/features/payment/transaction/models/verify_payment.dart';
import 'package:church_clique/features/payment/views/main_payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
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
    } on Exception catch (e) {
      print(e.toString());
    }

    if (response!.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      final authUrl = responseData['authorization_url'];
      Provider.of<AuthorizationUrl>(context, listen: false).authUrl(authUrl);

      final reference = responseData['reference'];
      Provider.of<AuthorizationUrl>(context, listen:  false).setReference(reference);

      verifyPayment(reference: reference);
      print(authUrl);

      // sends the reference to the verify payment endpoint
      // checkTransactionStatus(authUrl, context);
    } else {
      Container(color: Colors.red,);
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
