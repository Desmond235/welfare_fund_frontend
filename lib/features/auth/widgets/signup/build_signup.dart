import 'package:church_clique/core/config/palette.dart';
import 'package:church_clique/features/auth/providers/auth_provider.dart';
import 'package:church_clique/features/auth/widgets/signup/gender.dart';
import 'package:church_clique/features/auth/widgets/signup/terms_condition.dart';
import 'package:church_clique/features/auth/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpWidget extends StatelessWidget {
  const SignUpWidget({
    super.key,
    required this.isSignupScreen,
  });

  final bool isSignupScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const SizedBox(height: 20,),
        TextFieldWidget(),
        SignupGenderSelection(),
        TermsAndConditions()
      ],
    );
  }
}
