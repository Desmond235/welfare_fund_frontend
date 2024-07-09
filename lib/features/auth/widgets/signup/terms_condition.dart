import 'package:church_clique/config/palette.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          width: 220,
          child: Text(
            textAlign: TextAlign.center,
            "By pressing 'submit' you agree to ",
            style: TextStyle(color: Palette.textColor1, fontSize: 14),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'our',
              style: TextStyle(fontSize: 14, color: Palette.textColor1),
            ),
            const SizedBox(width: 5),
            InkWell(
              onTap: () {},
              child: Text(
                'terms & conditions',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.yellow[700],
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.yellow[700],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
