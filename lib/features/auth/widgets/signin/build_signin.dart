import 'package:church_clique/core/constants/palette.dart';
import 'package:church_clique/core/controls/obscure_text.dart';
import 'package:church_clique/features/auth/domain/sign_cache.dart';
import 'package:church_clique/features/auth/models/user_signin_model.dart';
import 'package:church_clique/features/auth/providers/auth_provider.dart';
import 'package:church_clique/core/components/input_control.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:provider/provider.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({
    super.key,
    required bool isSignupScreen,
    this.isRememberMe,
    this.username,
    required this.chkOnchanged,
    required this.onChanged,
    required this.controller,
  }) : _isSignUpScreen = isSignupScreen;
  final bool _isSignUpScreen;
  final void Function(String name)? username;
  final bool? isRememberMe;
  final void Function(String onChanged) onChanged;
  final void Function(bool? value) chkOnchanged;
  final TextEditingController? controller;

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
      child: Consumer<AuthProvider>(
        builder: (_, ref, __) {
          final rememberMe = ref.isRememberMe;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      ref.toggleLogin();
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
                      ref.toggleSignup();
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
                controller: widget.controller,
                onChanged: widget.onChanged,
                icon: MaterialCommunityIcons.account_outline,
                hintText: "info@example.com",
                isEmail: true,
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
                        obscureTextController.selection =
                            TextSelection.collapsed(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                    
                      Checkbox(
                        tristate: false,
                        value: widget.isRememberMe ?? false,
                        activeColor: Palette.textColor2,
                        onChanged: widget.chkOnchanged,
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
              ),
            ],
          );
        },
      ),
    );
  }
}
