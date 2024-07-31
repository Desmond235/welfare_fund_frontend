import 'package:church_clique/core/components/drop_down.dart';
import 'package:church_clique/core/components/input_control.dart';
import 'package:church_clique/core/components/input_text.dart';
import 'package:church_clique/core/components/next-of-kin_class-leader.dart';
import 'package:church_clique/core/components/send_button.dart';
import 'package:church_clique/core/constants/palette.dart';
import 'package:church_clique/features/form/views/enum/category.dart';
import 'package:church_clique/features/form/widgets/input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:icons_flutter/icons_flutter.dart';

class SecondForm extends StatefulWidget {
  const SecondForm({super.key});

  @override
  State<SecondForm> createState() => _SecondFormState();
}

class _SecondFormState extends State<SecondForm> {
  String? initialValue;
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
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Please enter a correct house number';
                      }
                      return null;
                    },
                    icon: MaterialCommunityIcons.home_outline,
                    hintText: 'H/No./Digital Address',
                  ),
                  const SizedBox(height: 10),
                  BuildTextInput(
                    type: TextInputType.text,
                    validator: (value) {
                      if (value!.trim().isEmpty ||
                          !RegExp(r'/S').hasMatch(value)) {
                        return 'Please enter a valid house address';
                      }
                      return null;
                    },
                    icon: Icons.home_outlined,
                    hintText: 'Place of Abode',
                  ),
                  const SizedBox(height: 10),
                  BuildTextInput(
                    type: TextInputType.text,
                    // FIXME: landmark
                    // validator: (value) {
                    //   if (value!.trim().isEmpty ||
                    //       value.trim().length > 6 ||
                    //       !RegExp(r'\d').hasMatch(value)) {
                    //     return 'Invalid phone number';
                    //   }
                    //   return null;
                    // },
                    icon: Icons.landscape,
                    hintText: 'Landmark',
                  ),
                  const SizedBox(height: 10),
                  BuildTextInput(
                    type: TextInputType.text,
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return 'Please enter a valid house address';
                      }
                      return null;
                    },
                    icon: Icons.location_city_outlined,
                    hintText: 'Hometown',
                  ),
                  const SizedBox(height: 10),
                  BuildTextInput(
                    type: TextInputType.text,
                    validator: (value) {
                      if (value!.trim().isEmpty ||
                          !RegExp(r'/S').hasMatch(value)) {
                        return 'required field';
                      }
                      return null;
                    },
                    icon: Icons.place_outlined,
                    hintText: 'Region',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: SizedBox(
                      // width: MediaQuery.of(context).size.width * 0.52,
                      child: DropdownButtonFormField(
                        hint: Text(
                          'Choose marital status',
                          style: TextStyle(color: Palette.textColor1),
                        ),
                        value: initialValue,
                        items: MaritalStatus.values
                            .map((status) => DropdownMenuItem(
                                  value: status.name,
                                  child: Text(
                                    status.name,
                                    style: TextStyle(
                                      color: Palette.textColor1,
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          initialValue = value!;
                        },
                        decoration: inputDecoration(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  BuildTextInput(
                    icon: Icons.info_outline,
                    hintText: 'Others',
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: sendButton(
                      context: context,
                      onTap: () {
                        Navigator.of(context).pushNamed('third_form');
                      },
                      text: 'Next',
                      icon: MaterialCommunityIcons.arrow_right,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
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
