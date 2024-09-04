import 'package:church_clique/core/constants/palette.dart';
import 'package:church_clique/features/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class BuildTextInput extends StatefulWidget {

  /// A custom widget for building and styling text input fields.
///
/// This widget is used to create and customize text input fields in the application.
/// It includes various parameters to customize the appearance and behavior of the input field.
  const BuildTextInput({
    super.key,
    this.icon,
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

 /// The icon to be displayed at the beginning of the input field.
  final IconData? icon;

  /// Indicates whether the input field should accept an email address.
  final bool? isEmail;

  /// The hint text to be displayed when the input field is empty.
  final String hintText;

  /// The validator function to be called when the input field loses focus.
  final FormFieldValidator<String>? validator;

  /// The type of keyboard to be displayed when the input field is focused.
  final TextInputType? type;

  /// The controller for managing the text in the input field.
  final TextEditingController? controller;

  /// The maximum length of the input text.
  final int? maxLength;

  /// The maximum number of lines for multi-line input fields.
  final int? maxLines;

  /// The function to be called when the input field loses focus and the form is saved.
  final void Function(String? value)? onSaved;

  /// The function to be called when the input text changes.
  final void Function(String value)? onChanged;

  /// The action to be performed when the user presses the return key on the keyboard.
  final TextInputAction? textInputAction;


  @override
  State<BuildTextInput> createState() => _BuildTextInputState();
}

class _BuildTextInputState extends State<BuildTextInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        maxLines: widget.maxLines,
        onChanged: widget.onChanged,
        controller: widget.controller,
        textInputAction: widget.textInputAction,
        autocorrect: false,
        inputFormatters: [
          // if(widget.type == TextInputType.text)
          // FilteringTextInputFormatter.allow(RegExp(r'\w( )?')),
          // FilteringTextInputFormatter.deny(RegExp(r'\d')),
          if (widget.type == TextInputType.phone)
            FilteringTextInputFormatter.allow(RegExp(r'\d')),
          LengthLimitingTextInputFormatter(
              widget.type == TextInputType.phone ? 10 : widget.maxLength),
        ],
        style: TextStyle(
            color:
                Provider.of<ThemeProvider>(context, listen: false).isDarkMode ||
                        Provider.of<ThemeProvider>(context, listen: false)
                            .isDarkTheme
                    ? Colors.white
                    : Colors.black),
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
              borderSide: const BorderSide(color: Palette.textColor1)),
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Palette.textColor1),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: const BorderSide(color: Palette.textColor1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: const BorderSide(color: Palette.textColor1),
          ),
        ),
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
      ),
    );
  }
}
