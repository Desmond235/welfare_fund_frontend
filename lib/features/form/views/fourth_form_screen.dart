import 'package:church_clique/core/components/drop_down.dart';
import 'package:church_clique/core/components/input_control.dart';
import 'package:church_clique/core/components/input_text.dart';
import 'package:church_clique/core/components/next-of-kin_class-leader.dart';
import 'package:church_clique/core/components/send_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class FourthFormScreen extends StatefulWidget {
  const FourthFormScreen({super.key});

  @override
  State<FourthFormScreen> createState() => _FourthFormScreenState();
}

class _FourthFormScreenState extends State<FourthFormScreen> {
  showDialogBox() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure you want to cancel operation?'),
            content: Text("All details will be cleared"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                  )),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(context, 'main', (route)=> false);
                },
                child: Text('Ok'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      appBar: AppBar(
        title: Text('Membership Form'),
      ),
      body: SafeArea(
        child: KeyboardDismissOnTap(
          child: Padding(
            padding:  EdgeInsets.fromLTRB(20, 20, 20,  10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: BuildTextInput(
                        type: TextInputType.text,
                        validator: (value) {
                          if (value!.trim().isEmpty ||
                              !RegExp(r'\S( )?').hasMatch(value)) {
                            return "Please enter letters only";
                          }
                          return null;
                        },
                        icon: Icons.woman_outlined,
                        hintText: 'Biological Mother\'s name',
                      ),
                    ),
                    const SizedBox(height: 10),
                    dropDownButton(),
                    const SizedBox(height: 10),
                  kinClassLeader('Next of Kin'),
                  const SizedBox(height: 10),
                  kinClassLeader('Class Leader'),
                  const SizedBox(height: 10),
                  inputText(
                    Icons.person,
                    'Organization of Member (if applicable)',
                    TextInputType.phone,
                  ),
                  const SizedBox(height: 10),
                  inputText(
                    Icons.phone,
                    'Org. Leader\'s Contact',
                    TextInputType.phone,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: sendButton(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          context: context,
                          onTap: showDialogBox,
                          text: "Cancel",
                          icon: Icons.cancel,
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: sendButton(
                          context: context,
                          onTap: () {},
                          text: 'Submit',
                          icon: Icons.send,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                      ),
                    ],
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
