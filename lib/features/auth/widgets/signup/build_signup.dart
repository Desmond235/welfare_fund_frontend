import 'package:church_clique/core/config/palette.dart';
import 'package:church_clique/features/auth/providers/auth_provider.dart';
import 'package:church_clique/features/auth/widgets/signup/gender.dart';
import 'package:church_clique/features/auth/widgets/signup/terms_condition.dart';
import 'package:church_clique/core/constants.dart/input_control.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:provider/provider.dart';

class SignUpWidget extends StatefulWidget {
  SignUpWidget({
    super.key,
    required this.isSignupScreen,
  });

  final bool isSignupScreen;

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  bool showPassword = true;
  final passwordController = TextEditingController();
  final obscureTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Provider.of<AuthProvider>(context, listen: false).toggleLogin();
              },
              child: Column(
                children: [
                  Text(
                    "LOGIN",
                    style: TextStyle(
                      fontSize: 16,
                      color: !widget.isSignupScreen
                          ? Palette.activeColor
                          : Palette.textColor1,
                    ),
                  ),
                  if (!widget.isSignupScreen)
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
                      color: widget.isSignupScreen
                          ? Palette.activeColor
                          : Palette.textColor1,
                    ),
                  ),
                  if (widget.isSignupScreen)
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
        const SizedBox(
          height: 20,
        ),
        Consumer<AuthProvider>(
          builder: (context,credentials, child) {
            return Container(
              child: Column(
                children: [
                  // field for entering registration username
                  BuildTextInput(
                    icon: MaterialCommunityIcons.account_outline,
                    hintText: 'User Name',
                    onSaved: (value) {
                      credentials.onSaveUsername = value!;
                    },
                    // validation for username
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Please enter username";
                      }
                      return null;
                    },
                  ),

                  // field for entering registration email
                  BuildTextInput(
                    icon: Icons.email_outlined,
                    hintText: 'Email',
                    isEmail: true,
                    onSaved: (value) {
                      credentials.onSaveEmail = value!;
                    },
                    // validation for email
                    validator: (value) {
                      if (value!.trim().isEmpty ||
                          !RegExp(r'/S/+@/+/S+/.+/S').hasMatch(value.trim())) {
                        return 'Please enter a valid email address;';
                      }
                      return null;
                    },
                  ),

                  // field for entering registration password
                  TextFormField(
                    controller: showPassword
                        ? passwordController
                        : obscureTextController,
                    onSaved: (value) {
                      credentials.onSavePassword = value!;
                    },
                    validator: (value) {
                      if (value!.trim().isEmpty || value.trim().length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        hintText: "Password",
                        hintStyle: TextStyle(color: Palette.textColor1),
                        prefixIcon: Icon(
                          MaterialCommunityIcons.lock,
                          color: Palette.textColor1,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (showPassword) {
                              obscureTextController.text =
                                  passwordController.text;
                              obscureTextController.selection =
                                  TextSelection.collapsed(
                                      offset:
                                          obscureTextController.text.length);
                            } else {
                              passwordController.text =
                                  obscureTextController.text;
                              passwordController.selection =
                                  TextSelection.collapsed(
                                      offset: passwordController.text.length);
                            }
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          icon: Icon(
                            showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Palette.iconColor,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide:
                                const BorderSide(color: Palette.textColor1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
                            borderSide:
                                const BorderSide(color: Palette.textColor1))),
                  )
                ],
              ),
            );
          },
        ),
        SignupGenderSelection(),
        TermsAndConditions(),
      ],
    );
  }
}
