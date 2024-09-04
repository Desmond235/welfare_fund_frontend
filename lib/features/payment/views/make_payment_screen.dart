// import 'package:church_clique/core/constants/constants.dart';
// import 'package:church_clique/core/service/payment_response.dart';
// import 'package:church_clique/features/payment/model/payment_model.dart';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class MakePaymentScreen extends StatefulWidget {
//   const MakePaymentScreen(
//       {super.key,
//       required this.amount,
//       required this.email,
//       required this.currency});
//   final String amount;
//   final String email;
//   final String currency;

//   @override
//   State<MakePaymentScreen> createState() => _MakePaymentScreenState();
// }

// class _MakePaymentScreenState extends State<MakePaymentScreen> {
//   late Future<PaymentModel> makePayment;


//   String? authUrl;
//   Future<PaymentModel> _makePayment() async {
      
//     final paymentResponse = await PaymentResponse.makePayment(
//       amount: widget.amount,
//       email: widget.email,
//       currency: widget.currency,
//       context: context,
//     );
//     setState(() {
//       authUrl = paymentResponse.authorizationUrl;
//     });
//     return paymentResponse;
//   }

//   @override
//   void initState() {
//      makePayment = _makePayment();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: FutureBuilder(
//           future: makePayment,
//           builder: (context, snapshot) {
//             print(authUrl);
//             final controller = WebViewController()
//               ..setJavaScriptMode(JavaScriptMode.unrestricted)
//               ..setBackgroundColor(const Color(0x00000000))
//               ..setNavigationDelegate(
//                   NavigationDelegate(onNavigationRequest: (request) {
//                 if (request.url.startsWith('https://www.google.com')) {
//                   return NavigationDecision.prevent;
//                 }
//                 return NavigationDecision.navigate;
//               }));
//               // ..loadRequest(
//               //   Uri.parse(snapshot.data!.authorizationUrl),
//               // );

//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             if (snapshot.hasError) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Material(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Column(
//                           children: [
//                             const Icon(
//                               Icons.error,
//                               color: Colors.red,
//                             ),
//                             const SizedBox(height: 10),
//                             const Text('An error occurred'),
//                             const SizedBox(height: 10),
//                             ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: priCol(context),
//                               ),
//                               onPressed: () {
//                                 controller.reload();
//                               },
//                               child: const Text(
//                                 'Reload',
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             )
//                           ],
//                         )),
//                   ],
//                 ),
//               );
//             }

//             return WebViewWidget(controller: controller);
//           },
//         ),
//       ),
//     );
//   }
// }
