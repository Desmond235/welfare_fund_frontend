import 'package:church_clique/core/config/palette.dart';
import 'package:church_clique/features/auth/providers/auth_provider.dart';
import 'package:church_clique/features/auth/widgets/signup/pass_txt_field.dart';
import 'package:church_clique/features/auth/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:provider/provider.dart';

class SignInWidget extends StatelessWidget {
  const SignInWidget({super.key, required bool isSignupScreen})
      : _isSignUpScreen = isSignupScreen;
  final bool _isSignUpScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Provider.of<AuthProvider>(context, listen: false)
                      .toggleLogin();
                },
                child: Column(
                  children: [
                    Text(
                      "LOGIN",
                      style: TextStyle(
                        fontSize: 16,
                        color: !_isSignUpScreen
                            ? Palette.activeColor
                            : Palette.textColor1,
                      ),
                    ),
                    if (!_isSignUpScreen)
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
                  Provider.of<AuthProvider>(context, listen: false)
                      .toggleSignup();
                },
                child: Column(
                  children: [
                    Text(
                      'SIGNUP',
                      style: TextStyle(
                        fontSize: 16,
                        color: _isSignUpScreen
                            ? Palette.activeColor
                            : Palette.textColor1,
                      ),
                    ),
                    if (_isSignUpScreen)
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
          const SizedBox(height: 20),
          BuildTextInput(
            icon: MaterialCommunityIcons.account_outline,
            hintText: "info@example.com",
            isEmail: true,
            isPassword: false,
          ),
          PassTxtField(hintText: '*************'),
          Consumer<AuthProvider>(
            builder: (context, ref, child) {
              final isRememberMe = ref.isRememberMe;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: isRememberMe,
                        activeColor: Palette.textColor2,
                        onChanged: (value) {
                          ref.checkIsRememberMe(value!);
                        },
                      ),
                      const Text(
                        "Remember me",
                        style:
                            TextStyle(fontSize: 12, color: Palette.textColor1),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Forgot Password?",
                        style:
                            TextStyle(fontSize: 12, color: Palette.textColor1)),
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
