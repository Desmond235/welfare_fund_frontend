

 import 'package:church_clique/core/components/input_control.dart';
import 'package:flutter/material.dart';

BuildTextInput inputText(IconData icon, String text, TextInputType type) {
    return BuildTextInput(
      type: type,
      validator: (value) {
        if (value!.trim().isEmpty || !RegExp(r'\S( )?').hasMatch(value)) {
          return "Please enter letters only";
        }
        return null;
      },
      icon: icon,
      hintText: text,
    );
  }