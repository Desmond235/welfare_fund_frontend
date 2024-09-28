import 'package:church_clique/core/constants/palette.dart';
import 'package:church_clique/core/controls/obscure_text.dart';
import 'package:church_clique/features/auth/providers/auth_provider.dart';
import 'package:church_clique/core/components/input_control.dart';
import 'package:church_clique/features/auth/providers/change_password_provider.dart';
import 'package:church_clique/features/auth/providers/sign_provider.dart';
import 'package:church_clique/features/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:provider/provider.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({
    super.key,
    required bool isSignupScreen,
    this.isRememberMe,
    this.username,
    required this.onChanged,
    required this.passwordController,
  }) : _isSignUpScreen = isSignupScreen;

  final bool _isSignUpScreen;
  final void Function(String name)? username;
  final bool? isRememberMe;
  final void Function(String onChanged) onChanged;

  final TextEditingController passwordController;

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  bool showPassword = false;
  final obscureTextController = ObscuringTextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (_, ref, __) {
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
                          color: !widget._isSignUpScreen &&
                                      context
                                          .watch<ThemeProvider>()
                                          .isDarkMode ||
                                  context.watch<ThemeProvider>().isDarkTheme
                              ? Colors.white
                              : !widget._isSignUpScreen &&
                                          !context
                                              .watch<ThemeProvider>()
                                              .isDarkMode ||
                                      !context
                                          .watch<ThemeProvider>()
                                          .isDarkTheme
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
                              ? const Color.fromARGB(255, 154, 243, 112)
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
              maxLines: 1,
              type: TextInputType.emailAddress,
              onChanged: widget.onChanged,
              onSaved: (value) {
                Provider.of<SignInProvider>(context, listen: false)
                    .saveUsername(value!);
              },
              icon: MaterialCommunityIcons.account_outline,
              hintText: "username",
              isEmail: true,
            ),

            /// A TextFormField widget for password input with show/hide functionality.
            /// It uses two TextEditingControllers: [passwordController] for showing the password and
            /// [obscureTextController] for hiding the password. The [showPassword] boolean flag is used to
            /// toggle between the two controllers.
            ///
            /// The [contentPadding], [hintText], [hintStyle], [border], [prefixIcon], and [suffixIcon]
            /// properties are used to customize the appearance of the TextFormField.
            ///
            /// The [suffixIcon] contains an IconButton that toggles the visibility of the password.
            /// When the password is visible, the [suffixIcon] displays an [Icons.visibility] icon.
            /// When the password is hidden, the [suffixIcon] displays an [Icons.visibility_off] icon.
            ///
            /// The [enabledBorder] and [focusedBorder] properties are used to customize the border of the
            /// TextFormField when it is not focused and when it is focused, respectively.
            TextFormField(
              style: TextStyle(
                color: context.watch<ThemeProvider>().isDarkMode ||
                        context.watch<ThemeProvider>().isDarkTheme
                    ? Colors.white
                    : Colors.black,
              ),
              controller: showPassword
                  ? widget.passwordController
                  : obscureTextController,
              onSaved: (value) {
                Provider.of<SignInProvider>(context, listen: false)
                    .savePassword(value!);
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                hintText: "Password",
                hintStyle: const TextStyle(color: Palette.textColor1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                  borderSide: const BorderSide(color: Palette.textColor1),
                ),
                prefixIcon: const Icon(
                  MaterialCommunityIcons.lock,
                  color: Palette.textColor1,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    if (showPassword) {
                      obscureTextController.text =
                          widget.passwordController.text;
                      obscureTextController.selection = TextSelection.collapsed(
                        offset: obscureTextController.text.length,
                      );
                    } else {
                      widget.passwordController.text =
                          obscureTextController.text;
                      widget.passwordController.selection =
                          TextSelection.collapsed(
                        offset: widget.passwordController.text.length,
                      );
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
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                  borderSide: const BorderSide(color: Palette.textColor1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                  borderSide: const BorderSide(color: Palette.textColor1),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Row(
                //   children: [
                //     Checkbox(
                //       tristate: false,
                //       value: widget.isRememberMe ?? false,
                //       activeColor: Palette.textColor2,
                //       onChanged: widget.chkOnchanged,
                //     ),
                //     const Text(
                //       "Remember me",
                //       style:
                //           TextStyle(fontSize: 12, color: Palette.textColor1),
                //     ),
                //   ],
                // ),
                TextButton(
                  onPressed: () async {
                    context
                        .read<ChangePasswordProvider>()
                        .setIsChangePassword(true);
                    context
                        .read<ChangePasswordProvider>()
                        .setForgetPassword(true);
                    Navigator.of(context).pushNamed('email');
                  },
                  child: const Text("Forgot Password?",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 12, color: Palette.textColor1)),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
