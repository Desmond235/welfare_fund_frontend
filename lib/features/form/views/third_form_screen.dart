import 'package:church_clique/core/components/drop_down.dart';
import 'package:church_clique/core/components/input_control.dart';
import 'package:church_clique/core/components/input_text.dart';
import 'package:church_clique/core/components/next-of-kin_class-leader.dart';
import 'package:church_clique/core/components/send_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:icons_flutter/icons_flutter.dart';

class ThirdFormScreen extends StatefulWidget {
  const ThirdFormScreen({super.key});

  @override
  State<ThirdFormScreen> createState() => _ThirdFormScreenState();
}

class _ThirdFormScreenState extends State<ThirdFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Membership Form'),
      ),
      body: SafeArea(
        child: KeyboardDismissOnTap(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                   BuildTextInput(
                    type: TextInputType.text,
                    icon: Icons.person_outline_outlined,
                    hintText: 'Name of Spouse (IF MARRIED)',
                    validator: (value) {
                      if (value!.trim().isEmpty ||
                          !RegExp(r'/S').hasMatch(value)) {
                        return "Please enter the name of your spouse";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  dropDownButton(),
                  const SizedBox(height: 20),
                  BuildTextInput(
                    type: TextInputType.number,
                    icon: Icons.boy,
                    hintText: "Number of children",
                  ),
                  const SizedBox(height: 10),
                  BuildTextInput(
                    maxLines: null,
                    type: TextInputType.multiline,
                    icon: MaterialCommunityIcons.alphabetical,
                    hintText: 'Names of Children',
                  ),
                  const SizedBox(height: 10),
                  BuildTextInput(
                    type: TextInputType.text,
                    validator: (value) {
                      if (value!.trim().isEmpty ||
                          !RegExp(r'\S( )?').hasMatch(value)) {
                        return "Please enter letters only";
                      }
                      return null;
                    },
                    icon: MaterialCommunityIcons.worker,
                    hintText: 'Occupation',
                  ),
                  const SizedBox(height: 10),
                  inputText(
                    Icons.man_outlined,
                    'Biological Father\'s name',
                    TextInputType.text,
                  ),
                  const SizedBox(height: 10),
                  dropDownButton(),
                  const SizedBox(height: 20),
                  sendButton(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    context: context,
                    onTap: () {
                      Navigator.of(context).pushNamed('fourth_form');
                    },
                    text: "Next",
                    icon: MaterialCommunityIcons.arrow_right,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
