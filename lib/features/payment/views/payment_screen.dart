// import 'package:church_clique/core/constants/palette.dart';
import 'package:church_clique/core/components/input_control.dart';
import 'package:church_clique/core/components/send_button.dart';
import 'package:church_clique/core/service/payment_service.dart';
import 'package:church_clique/features/payment/data/data.dart';
import 'package:church_clique/features/payment/views/main_payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:uuid/uuid.dart';
// import 'package:pay_with_paystack/pay_with_paystack.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  String enteredAmount = '';
  String enteredEmail = '';
  final uuid = Uuid();

  /// This function is responsible for validating the form inputs and navigating to the
  /// [MakePaymentScreen] with the provided payment details.
  ///
  /// The function first checks if the form is valid using the form key's current state.
  /// If the form is valid, it saves the form data and then navigates to the
  /// [MakePaymentScreen] using a [MaterialPageRoute]. The payment details are passed
  /// as arguments to the [MakePaymentScreen].
  void makePayment() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    PaymentService.sendPayment(
      amount: enteredAmount,
      email: enteredEmail,
      currency: 'GHS',
    );
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainPaymentScreen()));
  }

  @override

  /// This function builds the payment screen UI. It returns a [Scaffold] widget with an [AppBar] and a [Form] as the body.
  /// The form contains three [BuildTextInput] widgets for collecting payment details: amount, email, and reference.
  /// It also includes a [SizedBox] with an [ElevatedButton] to trigger the payment process.
  ///
  /// @param context The build context for the widget.
  ///
  /// @return A [Scaffold] widget with the payment screen UI.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                BuildTextInput(
                  icon: Icons.payment,
                  hintText: "Amount",
                  onSaved: (value) {
                    enteredAmount = value!;
                  },
                  validator: (value) {
                    if (value!.trim().isEmpty ||
                        !RegExp(r'\d').hasMatch(value)) {
                      return 'Please enter a valid amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                BuildTextInput(
                  icon: MaterialCommunityIcons.email_outline,
                  hintText: 'info@example.com',
                  onSaved: (value) {
                    enteredEmail = value!;
                  },
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        !RegExp(r'\S\@\S+\.\S').hasMatch(value)) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    sendButton(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      context: context,
                      onTap: makePayment,
                      text: "Proceed to make payment",
                      icon: Icons.payment,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
