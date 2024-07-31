

import 'package:church_clique/core/components/input_control.dart';
import 'package:flutter/material.dart';

Row kinClassLeader(
    String text,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: BuildTextInput(
            type: TextInputType.text,
            validator: (value) {
              if (value!.trim().isEmpty || !RegExp(r'\S( )?').hasMatch(value)) {
                return "Please enter letters only";
              }
              return null;
            },
            icon: Icons.person,
            hintText: text,
          ),
        ),
         const SizedBox(width: 10),
        Expanded(
          child: BuildTextInput(
            type: TextInputType.phone,
            validator: (value) {
              if (value!.trim().isEmpty) {
                return "Please enter contact of next of kin";
              }
              return null;
            },
            icon: Icons.phone,
            hintText: 'Contact',
          ),
        ),
      ],
    );
  }
