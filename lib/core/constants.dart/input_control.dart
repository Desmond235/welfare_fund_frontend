import 'package:church_clique/core/config/palette.dart';
import 'package:church_clique/core/controls/obscure_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BuildTextInput extends StatefulWidget {
  const BuildTextInput({
    super.key,
    required this.icon,
    this.isEmail,
    this.isPassword,
    required this.hintText,
    this.validator,
    this.type,
    this.maxLength,
    this.passwordController,
    this.obscurePasswordController,
    this.onSaved
  });

  final bool? isPassword;
  final bool? isEmail;
  final IconData icon;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final TextInputType? type;
  final int? maxLength;
  final TextEditingController? passwordController;
  final TextEditingController? obscurePasswordController;
  final void Function(String? value)? onSaved;
  
  
  @override
  State<BuildTextInput> createState() => _BuildTextInputState();
}

class _BuildTextInputState extends State<BuildTextInput> {
  var obscurePasswordController = ObscuringTextEditingController();
  var passwordController = TextEditingController();
  bool showPassword = true;

  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        inputFormatters: [
          if(widget.type == TextInputType.phone)
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(
            widget.type == TextInputType.phone ? 10: widget.maxLength
          )
          
        ],
        validator: widget.validator,
        maxLength: widget.maxLength,
       onSaved: widget.onSaved,
        keyboardType: widget.isEmail == true
            ? TextInputType.emailAddress
            : TextInputType.text,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(10),
          prefixIcon: Icon(
            widget.icon,
            color: Palette.iconColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: BorderSide(color: Palette.textColor1)
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
      ),
    );
  }
}
