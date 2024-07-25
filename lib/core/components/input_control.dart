import 'package:church_clique/core/constants/palette.dart';
import 'package:church_clique/core/controls/obscure_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BuildTextInput extends StatefulWidget {
  const BuildTextInput({
    super.key,
    required this.icon,
    this.isEmail,
    required this.hintText,
    this.validator,
    this.type,
    this.controller,
    this.maxLength,
    this.onSaved,
    this.onChanged,
    this.textInputAction,
    this.maxLines,
  });

  final bool? isEmail;
  final IconData icon;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final TextInputType? type;
  final TextEditingController? controller;
  final int? maxLength;
  final int? maxLines;
  final void Function(String? value)? onSaved;
  final void Function(String value)? onChanged;
  final TextInputAction? textInputAction;
  
  
  
  @override
  State<BuildTextInput> createState() => _BuildTextInputState();
}

class _BuildTextInputState extends State<BuildTextInput> {

  @override
  Widget build(BuildContext context) {
    final dd  = TextEditingController();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(

        maxLines: widget.maxLines ,
        onChanged: widget.onChanged ,
        controller: widget.controller,
        textInputAction: widget.textInputAction ,
        autocorrect: false,
        inputFormatters: [
          // if(widget.type == TextInputType.text)
          // FilteringTextInputFormatter.allow(RegExp(r'\w( )?')),
          // FilteringTextInputFormatter.deny(RegExp(r'\d')),
          if(widget.type == TextInputType.phone)
          FilteringTextInputFormatter.allow(RegExp(r'\d')),
          LengthLimitingTextInputFormatter(
            widget.type == TextInputType.phone ? 10: widget.maxLength
          ),
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