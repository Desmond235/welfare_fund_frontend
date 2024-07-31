

import 'package:church_clique/core/constants/palette.dart';
import 'package:church_clique/features/form/views/enum/category.dart';
import 'package:church_clique/features/form/widgets/input_decoration.dart';
import 'package:flutter/material.dart';

DropdownButtonFormField<String> dropDownButton() {
    String? aliveValue;
    return DropdownButtonFormField(
      value: aliveValue,
      hint: Text(
        'Alive or Deceased',
        style: TextStyle(color: Palette.textColor1),
      ),
      items: Life.values
          .map(
            (life) => DropdownMenuItem(
              value: life.name,
              child: Text(
                life.name,
                style: TextStyle(color: Palette.textColor1),
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        aliveValue = value!;
      },
      decoration: inputDecoration(),
    );
  }
