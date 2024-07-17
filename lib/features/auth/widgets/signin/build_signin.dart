import 'package:church_clique/core/constants/palette.dart';
import 'package:church_clique/core/controls/obscure_text.dart';
import 'package:church_clique/features/auth/providers/auth_provider.dart';
import 'package:church_clique/core/constants/input_control.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:provider/provider.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({super.key, required bool isSignupScreen})
      : _isSignUpScreen = isSignupScreen;
  final bool _isSignUpScreen;

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  bool showPassword = true;
  final passwordController = TextEditingController();
  final obscureTextController = ObscuringTextEditingController();
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
                        color: !widget._isSignUpScreen
                            ? Palette.activeColor
                            : Palette.textColor1,
                      ),
                    ),
                    if (!widget._isSignUpScreen)
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
                        color: widget._isSignUpScreen
                            ? Palette.activeColor
                            : Palette.textColor1,
                      ),
                    ),
                    if (widget._isSignUpScreen)
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
          TextFormField(
            controller:
                showPassword ? passwordController : obscureTextController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              hintText: "Password",
              hintStyle: TextStyle(color: Palette.textColor1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: BorderSide(color: Palette.textColor1),
              ),
              prefixIcon: Icon(
                MaterialCommunityIcons.lock,
                color: Palette.textColor1,
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  if (showPassword) {
                    obscureTextController.text = passwordController.text;
                    obscureTextController.selection = TextSelection.collapsed(
                        offset: obscureTextController.text.length);
                  } else {
                    passwordController.text = obscureTextController.text;
                    passwordController.selection = TextSelection.collapsed(
                        offset: passwordController.text.length);
                  }
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                icon: Icon(
                  showPassword ? Icons.visibility : Icons.visibility_off,
                  color: Palette.iconColor,
                ),
              ),
              
              // enabledBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(35),
              //   borderSide: const BorderSide(color: Palette.textColor1),
              // ),
              // focusedBorder: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(35),
              //   borderSide: const BorderSide(color: Palette.textColor1),
              // ),
            ),
          ),
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
