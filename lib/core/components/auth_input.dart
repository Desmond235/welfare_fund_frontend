import 'package:flutter/material.dart';

class AuthInput extends StatelessWidget {
  const AuthInput({super.key, required this.hintText});
  final  String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText ,
        contentPadding: const EdgeInsets.all(10),
        
      ),
    );
  }
}