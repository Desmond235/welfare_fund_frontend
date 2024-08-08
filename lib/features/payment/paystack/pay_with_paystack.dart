import 'package:church_clique/core/config/environ.dart';
import 'package:flutter/material.dart';
import 'package:pay_with_paystack/pay_with_paystack.dart';

class PayWithPaystack {
  PayWithPaystack(this.amount, this.email, this.context);
  BuildContext context;
  double amount;
  String email;


  makePayment() async{
    final uniqueTransRef = PayWithPayStack().generateUuidV4();

    final payment = await  PayWithPayStack().now(
        context: context,
        secretKey: EnvironConfig.secretKey!,
        customerEmail: email,
        callbackUrl: '',
        
        paymentChannel: ['card', 'mobile_money' ],
        reference: uniqueTransRef,
        currency: "GHS",
        amount: amount,
        transactionCompleted: () {
          print("Transaction Successful");
        },
        transactionNotCompleted: () {
          print("Transaction Not Successful!");
        });
  }
}
