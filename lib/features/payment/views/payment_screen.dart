// import 'package:church_clique/core/constants/palette.dart';
import 'package:church_clique/core/components/input_control.dart';
import 'package:church_clique/core/components/menu_item.dart';
import 'package:church_clique/core/components/send_button.dart';
import 'package:church_clique/core/service/payment_service.dart';
import 'package:church_clique/features/payment/views/main_payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
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
  final uuid = const Uuid();
  final _drawerController = AdvancedDrawerController();

  void makePayment() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    PaymentService.sendPayment(context,
        amount: enteredAmount,
        email: enteredEmail,
        currency: 'GHS',
        metadata: {'cancel-action': 'your-cancel-url.com'});
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const MainPaymentScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: MenuItem(
        drawerController: _drawerController,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBarScreen(
            drawerController: _drawerController,
            title: 'Send Contribution',
          ),
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
        ),
      ),
    );
  }
}
