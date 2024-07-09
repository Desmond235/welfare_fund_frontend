import 'package:church_clique/config/palette.dart';
import 'package:church_clique/features/auth/providers/auth_provider.dart';
import 'package:church_clique/features/auth/widgets/signup/gender.dart';
import 'package:church_clique/features/auth/widgets/signup/terms_condition.dart';
import 'package:church_clique/features/auth/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildSignIn extends StatelessWidget {
  const BuildSignIn({
    super.key,
    required this.isSignupScreen,
  });

  final bool isSignupScreen;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 200,
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        height: 390,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Provider.of<AuthProvider>(context,
                              listen: false)
                          .toggleLogin();
                    },
                    child: Column(
                      children: [
                        Text(
                          "LOGIN",
                          style: TextStyle(
                            fontSize: 16,
                            color: !isSignupScreen
                                ? Palette.activeColor
                                : Palette.textColor1,
                          ),
                        ),
                        if (!isSignupScreen)
                          Container(
                            height: 5,
                            width: 55,
                            color: Colors.orange,
                          ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Provider.of<AuthProvider>(context,
                      //         listen: false)
                      //     .toggleSignup();
                      Provider.of<AuthProvider>(context, listen: false).toggleSignup();
                    },
                    child: Column(
                      children: [
                        Text(
                          'SIGNUP',
                          style: TextStyle(
                            fontSize: 16,
                            color: isSignupScreen
                                ? Palette.activeColor
                                : Palette.textColor1,
                          ),
                        ),
                        if (isSignupScreen)
                          Container(
                            height: 5,
                            width: 55,
                            color: Colors.orange,
                          )
                      ],
                    ),
                  ),
                ],
              ),
              TextFieldWidget(),
              SignupGenderSelection(),
              TermsAndConditions()
            ],
          ),
        ),
      ),
    );
  }
}
