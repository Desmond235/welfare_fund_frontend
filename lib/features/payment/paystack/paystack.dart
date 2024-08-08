// import 'package:flutter/material.dart';
// import 'package:flutter_paystack/flutter_paystack.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// class PayStack {
//   PayStack(this.ctx, this.amount, this.email, this.reference);

//   BuildContext ctx;
//   int amount;
//   String email;
//   String reference;

//   PaystackPlugin paystack = PaystackPlugin();

//   // initialize paystack
//   Future initializePaystackPlugin() async {
//     await paystack.initialize(publicKey: dotenv.env['PUBLIC_KEY']!);
//   }

//   PaymentCard _getCardFromUI() {
//     return PaymentCard(
//       number: '',
//       cvc: '',
//       expiryMonth: 0,
//       expiryYear: 0,
//     );
//   }

//   // Method charging card
//   chargeCardAndMakePayment() async {
//     initializePaystackPlugin();
//     Charge charge = Charge()
//       ..amount = amount * 100
//       ..email = email
//       ..reference = reference
//       ..currency = "GHS"
//       ..card = _getCardFromUI();

//     CheckoutResponse response = await paystack.checkout(
//       ctx,
//       charge: charge,
//       method: CheckoutMethod.selectable,
//       logo: CircleAvatar(
//         radius: 20,
//         child: Image.asset('assets/logo.png'),
//       ),
//       fullscreen: false,
//     );
//     if(response.status == true){
//       print('Transaction successful');
//     }else{
//       print("Transaction failed");
//     }
//   }
// }
