import 'package:church_clique/core/service/verify_payment_service.dart';
import 'package:church_clique/features/form/provider/form_state.dart';
import 'package:church_clique/features/payment/data/data.dart';
import 'package:church_clique/features/payment/transaction/models/verify_payment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionDetailsScreen extends StatefulWidget {

  const TransactionDetailsScreen({super.key});

  @override
  State<TransactionDetailsScreen> createState() => _TransactionDetailsScreen();
}

class _TransactionDetailsScreen extends State<TransactionDetailsScreen> {
 Future<VerifyPaymentResponse>? futureVerifyPayment;

  String ? reference;


  @override


  void didChangeDependencies() {
    final provider = Provider.of<AuthorizationUrl>(context);
    final userId = context.watch<MemFormState>().userId;

     final newReference = provider.reference;
     if(reference != newReference && newReference.isNotEmpty) {
       reference = newReference;

      //  fetch new data when the reference changes
       futureVerifyPayment = verifyPayment(reference!, userId); 

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
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final VerifyPaymentResponse response = snapshot.data!;
            if (response.status == 'success') {
              return const Center(child: Text('Payment Verified!'));
            } else {
              return Center(child: Text('Payment Failed: ${response.data['message']}'));
            }
          } else {
            return const Center(child: Text('No Payment made yet'));
          }
        },
      ),
    );
  }
}
