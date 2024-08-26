import 'package:church_clique/core/components/input_control.dart';
import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/core/constants/palette.dart';
import 'package:church_clique/core/controls/obscure_text.dart';
import 'package:church_clique/core/service/change_password_service.dart';
import 'package:church_clique/core/service/http_service.dart';
import 'package:church_clique/features/auth/models/change_password_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:icons_flutter/icons_flutter.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangPasswordScreenState();
}

class _ChangPasswordScreenState extends State<ChangePasswordScreen> {
  bool showPassword = true;
  final passwordController = TextEditingController();
  final obscureTextController = ObscuringTextEditingController();
  final usernameController = TextEditingController();

  late ChangePasswordModel _affectedRows;

  void changePassword() async {
    final affectedRows = await ChangePasswordService.post(
      usernameController.text,
      passwordController.text,
    );

    setState(() {
      _affectedRows = affectedRows;
    });

    if (_affectedRows.affectedRows == 0) {
      if (!mounted) return;
      snackBar(context, "Invalid username");
      return;
    } else {
      if (!mounted) return;
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Change Password'),
              content:
                  const Text('Your password has been changed successfully.'),
              actions: [
                TextButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('auth', (route) => false);
                  },
                ),
              ],
            );
          });
    }
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    obscureTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: KeyboardDismissOnTap(
            child: Column(
              children: [
                const Text(
                  'Change Password',
                  style: TextStyle(fontSize: 17),
                ),
                const SizedBox(height: 20),
                  BuildTextInput(
                  hintText: 'Enter username',
                  icon: Icons.lock,
                  controller: usernameController,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  style: const TextStyle(color: Colors.black),
                  controller:
                      showPassword ? passwordController : obscureTextController,
                  // onSaved: (value) {
                  //   Provider.of<SignInProvider>(context, listen: false)
                  //       .savePassword(value!);
                  // },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "Enter new Password",
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
                          obscureTextController.text = passwordController.text;
                          obscureTextController.selection =
                              TextSelection.collapsed(
                            offset: obscureTextController.text.length,
                          );
                        } else {
                          passwordController.text = obscureTextController.text;
                          passwordController.selection =
                              TextSelection.collapsed(
                            offset: passwordController.text.length,
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
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: InkWell(
                    onTap: changePassword,
                    borderRadius: BorderRadius.circular(35),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomLeft,
                            colors: [
                              priCol(context).withOpacity(0.6),
                              priCol(context)
                            ],
                          )),
                      child: const Text(
                        'Save',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
