import 'package:church_clique/core/config/palette.dart';
import 'package:church_clique/core/controls/obscure_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_flutter/icons_flutter.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          BuildTextInput(
              icon: MaterialCommunityIcons.account_outline,
              hintText: 'User Name'),
          BuildTextInput(
            icon: Icons.email_outlined,
            hintText: 'Email',
            isEmail: true,
            validator: (value) {
              if (value!.trim().isEmpty ||
                  !RegExp(r'/S/+@/+/S+/.+/S').hasMatch(value.trim())) {
                return 'Please enter a valid email address;';
              }
              return null;
            },
          ),
          BuildTextInput(
              icon: MaterialCommunityIcons.lock,
              hintText: 'Password',
              isPassword: true),
        ],
      ),
    );
  }
}

class BuildTextInput extends StatefulWidget {
  const BuildTextInput({
    super.key,
    required this.icon,
    this.isEmail,
    this.isPassword,
    required this.hintText,
    this.validator,
    this.type,
    this.maxLength
  });

  final bool? isPassword;
  final bool? isEmail;
  final IconData icon;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final TextInputType? type;
  final int? maxLength;
  
  @override
  State<BuildTextInput> createState() => _BuildTextInputState();
}

class _BuildTextInputState extends State<BuildTextInput> {
  var obscurePasswordController = ObscuringTextEditingController();
  var passwordController = TextEditingController();
  bool showPassword = false;

  var _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Padding(
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
          controller:
              showPassword ? passwordController : obscurePasswordController,
          keyboardType: widget.isEmail == true
              ? TextInputType.emailAddress
              : TextInputType.text,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            suffixIcon: widget.isPassword == true
                ? IconButton(
                    onPressed: () {
                      if (showPassword) {
                        obscurePasswordController.text =
                            passwordController.text;
                        obscurePasswordController.selection =
                            TextSelection.collapsed(
                                offset: obscurePasswordController.text.length);
                      } else {
                        passwordController.text =
                            obscurePasswordController.text;
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
                  )
                : const SizedBox.shrink(),
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
        ),
      ),
    );
  }
}
