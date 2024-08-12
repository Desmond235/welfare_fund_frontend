import 'package:church_clique/core/service/verify_payment_service.dart';
import 'package:church_clique/features/payment/transaction/models/verify_payment.dart';
import 'package:flutter/material.dart';

class TransactionDetailsScreen extends StatefulWidget {

  TransactionDetailsScreen({super.key});

  @override
  _TransactionDetailsScreen createState() => _TransactionDetailsScreen();
}

class _TransactionDetailsScreen extends State<TransactionDetailsScreen> {
  late Future<VerifyPaymentResponse> futureVerifyPayment;

  @override
  void initState() {
    super.initState();
    futureVerifyPayment = verifyPayment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Payment'),
      ),
      body: FutureBuilder<VerifyPaymentResponse>(
        future: futureVerifyPayment,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final VerifyPaymentResponse response = snapshot.data!;
            if (response.status == 'success') {
              return Center(child: Text('Payment Verified!'));
            } else {
              return Center(child: Text('Payment Failed: ${response.data['message']}'));
            }
          } else {
            return Center(child: Text('No Data'));
          }
        },
      ),
    );
  }
}
