import 'package:church_clique/core/components/input_control.dart';
import 'package:flutter/material.dart';

BuildTextInput inputText(IconData icon, String text, TextInputType type,
   void Function(String? value) onSaved, [String? Function(String?)? validator]) {
  return BuildTextInput(
    type: type,
    onSaved: onSaved,
    
     validator: validator,
    icon: icon,
    hintText: text,
  );
}
