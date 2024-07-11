import 'package:church_clique/core/config/palette.dart';
import 'package:church_clique/core/controls/obscure_text.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';

class PassTxtField extends StatefulWidget {
  const PassTxtField({super.key,this.hintText});
  final String? hintText; 

  @override
  State<PassTxtField> createState() => _PassTxtFieldState();
}

class _PassTxtFieldState extends State<PassTxtField> {
    var passwordController = TextEditingController();
    var obscureTextController = ObscuringTextEditingController();
    bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: showPassword ? passwordController : obscureTextController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(10),
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Palette.textColor1),
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
             showPassword? Icons.visibility : Icons.visibility_off,
            color: Palette.iconColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: const BorderSide(
            color: Palette.textColor1
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35),
          borderSide: const BorderSide(
            color: Palette.textColor1
          )
        )
      ),
    );
  }
}
