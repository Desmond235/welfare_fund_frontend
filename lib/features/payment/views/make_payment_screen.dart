// import 'dart:convert';

// import 'package:church_clique/core/config/environ.dart';
// import 'package:church_clique/features/payment/Transaction/transaction.dart';
// import 'package:church_clique/features/payment/paystack/paystack_model.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class MakePaymentScreen extends StatefulWidget {
//   const MakePaymentScreen({
//     super.key,
//     required this.amount,
//     required this.email,
//     required this.reference,
//   });
//   final String amount;
//   final String email;
//   final String reference;

//   @override
//   State<MakePaymentScreen> createState() => _MakePaymentScreenState();
// }

// class _MakePaymentScreenState extends State<MakePaymentScreen> {
//   /// This function sends a POST request to the Paystack API endpoint to create a transaction.
// ///
// /// The function takes a [Transaction] object as a parameter, which contains the necessary details
// /// for the transaction such as amount, reference, currency, and email. The function converts the
// /// transaction object into JSON format and sends it as the request body.
// ///
// /// The function uses the [http] package to make the POST request. It includes the necessary headers
// /// for authentication and content type. The endpoint URL is obtained from the [EnvironConfig] class.
// ///
// /// If the request is successful (status code 200), the function decodes the response body and
// /// converts it into a [PaystackModel] object. The [PaystackModel] object contains the authorization
// /// URL for the transaction, which can be used to redirect the user to the Paystack payment page.
// ///
// /// If the request fails (status code other than 200), the function throws an exception with the
// /// message 'Failed to make payment'.
// ///
// /// If any other error occurs during the request, the function also throws an exception with the
// /// message 'Failed to make payment'.
// ///
// /// @param transaction The transaction object containing the necessary details for the transaction.
// /// @return A [Future] that resolves to a [PaystackModel] object containing the authorization URL.
// Future<PaystackModel> createTransaction(Transaction transaction) async {
//   final data = transaction.toJson();
//   try {
//     final response = await http.post(
//       Uri.parse(EnvironConfig.paystackEndpoint!),
//       headers: {
//         'Authorization': 'Bearer ${EnvironConfig.secretKey!}',
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(data),
//     );
//     if (response.statusCode == 200) {
//       final responseData = jsonDecode(response.body);
//       return PaystackModel.fromJson(responseData['data']);
//     } else {
//       throw 'Failed to make payment';
//     }
//   } on Exception {
//     throw 'Failed to make payment';
//   }
// }
//  /// Initializes a payment transaction with Paystack.
// ///
// /// This function attempts to create a transaction with the provided amount, reference, currency, and email.
// /// It first parses the amount from a string to a double. Then, it creates a [Transaction] object with the parsed amount,
// /// reference, currency, and email. The [createTransaction] function is called with the transaction object to create the transaction.
// ///
// /// If the transaction is successfully created, the authorization URL from the [PaystackModel] response is returned.
// /// If an error occurs during the transaction creation or parsing, the error message is printed and returned as a string.
// ///
// /// @param widget.amount The amount of the transaction in string format.
// /// @param widget.reference The reference for the transaction.
// /// @param widget.email The email of the customer.
// /// @return A [Future] that resolves to a string containing the authorization URL if the transaction is successful,
// /// or an error message if an error occurs.
// Future<String> initializeTransaction() async {
//   try {
//     final amount = double.tryParse(widget.amount);
//     final transaction = Transaction(
//       amount: (amount! * 100).toString(),
//       reference: widget.reference,
//       currency: 'GHS',
//       email: widget.email,
//       channels: ['mobile_money', ]
//     );
//     final authResponse = await createTransaction(transaction);
//     return authResponse.authorization_url;
//   } catch (e) {
//     print("Error initializing transaction: $e");
//     return e.toString();
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future: initializeTransaction(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final url = snapshot.data;
//             return SafeArea(
//               child: WebViewWidget(
//                 controller: WebViewController()
//                 ..setJavaScriptMode(JavaScriptMode.unrestricted)
//                   ..setBackgroundColor(const Color(0x00000000))
//                   ..setNavigationDelegate(
//                     NavigationDelegate(
//                       onProgress: (progress) {},
//                       onPageStarted:(url) {},
//                       onPageFinished: (url){},
//                       onHttpError: (error){},
//                       onWebResourceError: (error){},
//                       onNavigationRequest: (request){
//                         if(request.url.startsWith('https://www.youtube.com')){
//                           return NavigationDecision.prevent;
//                         }
//                         return NavigationDecision.navigate;
//                       }
//                     )
//                   )
//                   ..loadRequest(Uri.parse(url!))
//                 ,
//               ),
//             );
//           }else{
//             return Center(
//               child: const CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
