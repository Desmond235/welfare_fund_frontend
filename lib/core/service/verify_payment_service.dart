import 'dart:convert';
import 'package:church_clique/features/payment/transaction/models/verify_payment.dart';
import 'package:http/http.dart' as http;

Future<VerifyPaymentResponse> verifyPayment({String? reference}) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:3000/verify-payment'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'reference': reference}),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    return VerifyPaymentResponse.fromJson(responseData);
  } else {
    throw Exception('Failed to verify payment');
  }
}
