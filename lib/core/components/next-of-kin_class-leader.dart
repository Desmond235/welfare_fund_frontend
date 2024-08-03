import 'package:church_clique/core/components/input_control.dart';
import 'package:church_clique/features/form/data/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Row kinClassLeader(String text, BuildContext context,
    {required void Function(String?)? onSaved, required bool isClassLeader}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Expanded(
        child: BuildTextInput(
          type: TextInputType.text,
          onSaved: onSaved,
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
          onSaved: (value) {
            final provider = Provider.of<GetData>(context, listen: false);
            
               provider .saveNextOfKinContacts(value);
               provider.saveClassLeaderContact(value);
          },
          validator: (value) {
            if (value!.trim().isEmpty) {
              final text = isClassLeader == false
                  ? "Please enter contact of next of kin"
                  : "Please enter classLeader contact";
              return text;
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
