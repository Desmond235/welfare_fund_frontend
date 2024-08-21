import 'package:church_clique/core/components/input_control.dart';
import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/core/constants/palette.dart';
import 'package:flutter/material.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                'Enter the 6 digit code that was sent to your email',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: BuildTextInput(
                  type: TextInputType.phone,
                  hintText: 'Enter code',
                ),
              ),
            
              TextButton(onPressed: (){}, child: const Text('Resend code')),
            
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: priCol(context).withOpacity(0.7),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: const Text(
                      "Verify",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
