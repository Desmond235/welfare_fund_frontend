import 'package:church_clique/core/base/main/mainscreen.dart';
import 'package:church_clique/core/components/input_control.dart';
import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/core/constants/palette.dart';
import 'package:church_clique/core/service/verify_otp.dart';
import 'package:church_clique/features/auth/providers/change_password_provider.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

void verifyOtp( TextEditingController emailController){
  bool isChangedPassword = context.read<ChangePasswordProvider>().isChangedPassword;
  VerifyOtpResponse.post(otpController.text);

  if(isChangedPassword){
    Navigator.of(context).pushReplacementNamed('password');
  } else{
    Navigator.of(context).pushReplacementNamed('main');
  }
}
  
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text('Verify your account ',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
              const SizedBox(height: 50),
              const Text(
                'Enter the 6 digit code that was sent to your email',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
              ),
              // const Padding(
              //   padding: EdgeInsets.only(top: 20),
              //   child: BuildTextInput(
              //     type: TextInputType.phone,
              //     hintText: 'Enter code',
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Pinput(
                  controller: otpController,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  showCursor: true,
                  autofocus: true,
                  animationCurve: Curves.ease,
                  length: 6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Didn\'t receive code?',
                      style: TextStyle(
                        color: priCol(context),
                      ),
                    ),
                    const SizedBox(width: 3),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'Resend code',
                        style: TextStyle(
                          color: priCol(context),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => verifyOtp(otpController),
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
