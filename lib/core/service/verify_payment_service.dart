import 'dart:convert';
import 'package:church_clique/core/config/environ.dart';
import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/features/payment/transaction/models/verify_payment.dart';
import 'package:http/http.dart' as http;

Future<VerifyPaymentResponse> verifyPayment(String reference, int userId) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:3000/api/v1/verify-payment/$reference/$userId'),
    headers: {
      'Authorization': 'Bearer ${EnvironConfig.secretKey}',
    }
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    final id = responseData['id'];
    
    // Store the id in shared preferences
    final prefs = await sharedPrefs;
    prefs.setInt('id', id);
    return VerifyPaymentResponse.fromJson(responseData);

  } else {
    throw Exception('Failed to verify payment${response.statusCode}');
  }
}
