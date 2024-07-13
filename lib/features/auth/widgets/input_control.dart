import 'package:church_clique/core/config/palette.dart';
import 'package:church_clique/features/auth/widgets/signup/pass_txt_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_flutter/icons_flutter.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatelessWidget {
   TextFieldWidget({
    super.key,
    required this.passwordController,
    required this.obscureTextController,
    required this.onSaved,
    required this.enteredSignupUsername,
    required this.enteredSignupEmail,
    required this.enteredSignupPassword,
  });
  final TextEditingController passwordController;
  final TextEditingController obscureTextController;
  final void Function(String? value) onSaved;
  String enteredSignupUsername;
  String  enteredSignupEmail;
  String  enteredSignupPassword;


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BuildTextInput extends StatefulWidget {
  const BuildTextInput({y
    super.key,
    required this.icon,
    this.isEmail,
    this.isPassword,
    required this.hintText,
    this.validator,
    this.type,
    this.maxLength,
    this.onSave,
    this.controller,
  });

  final bool? isPassword;
  final bool? isEmail;
  final IconData icon;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final TextInputType? type;
  final int? maxLength;
  final TextEditingController? controller;
  final void Function(String? value)? onSave;

  @override
  State<BuildTextInput> createState() => _BuildTextInputState();
}

class _BuildTextInputState extends State<BuildTextInput> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        controller: widget.controller,
        inputFormatters: [
          if (widget.type == TextInputType.phone)
            FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(
              widget.type == TextInputType.phone ? 10 : widget.maxLength)
        ],
        validator: widget.validator,
        maxLength: widget.maxLength,
        keyboardType: widget.isEmail == true
            ? TextInputType.emailAddress
            : TextInputType.text,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          prefixIcon: Icon(
            widget.icon,
            color: Palette.iconColor,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Palette.textColor1),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: BorderSide(color: Palette.textColor1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: BorderSide(color: Palette.textColor1),
          ),
        ),
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        onSaved: widget.onSave,
      ),
    );
  }
}
