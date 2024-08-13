import 'package:church_clique/core/service/verify_payment_service.dart';
import 'package:church_clique/features/payment/data/data.dart';
import 'package:church_clique/features/payment/transaction/models/verify_payment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionDetailsScreen extends StatefulWidget {

  TransactionDetailsScreen({super.key});

  @override
  _TransactionDetailsScreen createState() => _TransactionDetailsScreen();
}

class _TransactionDetailsScreen extends State<TransactionDetailsScreen> {
 Future<VerifyPaymentResponse>? futureVerifyPayment;

  String ? reference;


  @override
  void didChangeDependencies() {
    final provider = Provider.of<AuthorizationUrl>(context);

     final new_reference = provider.reference;
     if(reference != new_reference && new_reference.isNotEmpty) {
       reference = new_reference;

       print(reference);
       print(new_reference);

      //  fetch new data when the reference changes
       futureVerifyPayment = verifyPayment(reference!); 

      //  force a rebuild of the screen when the reference changes.
      // This will trigger the FutureBuilder to fetch new data.
       setState(() {}); 
     } 
    super.didChangeDependencies();
  }
 
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Verify Payment'),
      // ),
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
            return Center(child: Text('No Payment made yet'));
          }
        },
      ),
    );
  }
}
