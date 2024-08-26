import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/core/constants/palette.dart';
import 'package:church_clique/core/controls/obscure_text.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text('Change password'),
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
                        obscureTextController.text = passwordController.text;
                        obscureTextController.selection =
                            TextSelection.collapsed(
                          offset: obscureTextController.text.length,
                        );
                      } else {
                        passwordController.text = obscureTextController.text;
                        passwordController.selection = TextSelection.collapsed(
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
                  onTap: (){},
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
    );
  }
}
