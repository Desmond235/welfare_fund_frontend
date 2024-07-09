import 'package:church_clique/core/config/palette.dart';
import 'package:church_clique/features/auth/providers/auth_provider.dart';
import 'package:church_clique/features/auth/widgets/signup/build_signup.dart';
import 'package:church_clique/features/auth/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: KeyboardDismissOnTap(
        child: Consumer<AuthProvider>(
          builder: (context, value, child) {
            bool isSignupScreen = value.isSignUp;
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 355,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/images/background.jpg',
                          ),
                          fit: BoxFit.cover),
                    ),
                    child: Container(
                      padding: const EdgeInsets.only(top: 40, left: 20),
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.75),
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: "Welcome to",
                                style: TextStyle(
                                  color: Colors.yellow[700],
                                  fontSize: width < 600 ? 20 : 25,
                                  letterSpacing: 2,
                                ),
                                children: [
                                  TextSpan(
                                      text: " Welfare Fund,",
                                      style: TextStyle(
                                          color: Colors.yellow[600],
                                          fontSize: width < 600 ? 20 : 25,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              isSignupScreen
                                  ? 'Signup to continue'
                                  : 'Signin to continue',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SubmitButton(isSignupScreen: isSignupScreen, isShadow: true),
                BuildSignIn(isSignupScreen: isSignupScreen),
                SubmitButton(isSignupScreen: isSignupScreen, isShadow: false,)
              ],
            );
          },
        ),
      ),
    );
  }
}

