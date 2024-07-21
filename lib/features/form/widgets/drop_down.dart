import 'package:church_clique/core/constants/palette.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
class DateTimePickerWidget extends StatelessWidget {
  const DateTimePickerWidget(
      {super.key, this.onPressed, required this.hintText});

  final void Function()? onPressed;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.67,
          child: TextFormField(
            readOnly: true,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: Palette.textColor1,
              ),
              contentPadding: const EdgeInsets.all(13),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: BorderSide(color: Palette.textColor1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: BorderSide(color: Palette.textColor2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: BorderSide(color: Palette.textColor1),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 22),
          child: IconButton(
            tooltip: "select Date",
            onPressed: onPressed,
            icon: Icon(
              MaterialCommunityIcons.calendar,
              color: Palette.textColor1,
              size: 25,
            ),
          ),
        )
      ],
    );
  }
}
