import 'package:church_clique/core/components/input_control.dart';
import 'package:church_clique/core/constants/palette.dart';
import 'package:church_clique/features/form/views/enum/category.dart';
import 'package:church_clique/features/form/widgets/drop_down.dart';
import 'package:church_clique/features/form/widgets/input_decoration.dart';
import 'package:church_clique/features/home/screens/home_screeb.dart';
import 'package:church_clique/features/home/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:icons_flutter/icons_flutter.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final date = DateTime.now();
  final firstDate = DateTime(1900);
  AdvancedDrawerController controller = AdvancedDrawerController();
  MaritalStatus initialValue = MaritalStatus.married;
  DateTime toDayDate() {
    return DateTime(date.year, date.month, date.day);
  }

  DateTime? _pickedDate;
  DateTime? DoBDate;
  DateTime? regisDate;
  // TODO:modify the last date

  void chosenDate(void Function(DateTime? pickedDate)? value) async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      initialDate: toDayDate(),
      lastDate: toDayDate(),
    );

    setState(() {
      _pickedDate = pickedDate;
    });

    value!(_pickedDate);

    print(regisDate!.toIso8601String());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeDrawer(
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BuildTextInput(
                        controller: TextEditingController(),
                        icon: MaterialCommunityIcons.account_outline,
                        hintText: "Full Name",
                        validator: (value) {
                          if (value!.trim().isEmpty ||
                              !RegExp(r'/S').hasMatch(value)) {
                            return "Invalid name";
                          }
                          return null;
                        },
                      ),

                      // TODO: display date chosen in text field
                      DateTimePickerWidget(
                        hintText: 'Date of Birth',
                        onPressed: () {
                          chosenDate(
                            (pickedDate) {
                              DoBDate = pickedDate;
                            },
                          );
                        },
                      ),
                      // TODO:Dispaly date chosen in text box
                      DateTimePickerWidget(
                        onPressed: () {
                          chosenDate(
                            (pickedDate) {
                              regisDate = pickedDate;
                            },
                          );
                        },
                        hintText: 'Date of Registration',
                      ),
                      const SizedBox(height: 7),
                      BuildTextInput(
                        validator: (value) {
                          if (value!.trim().isEmpty ||
                              !RegExp(r'\d').hasMatch(value)) {
                            return 'Invalid amount';
                          }
                          return null;
                        },
                        icon: Icons.payment_outlined,
                        hintText: 'Amount Paid GHC',
                      ),
                      const SizedBox(height: 7),
                      BuildTextInput(
                        type: TextInputType.text,
                        validator: (value) {
                          if (value!.trim().isEmpty ||
                              !RegExp(r'\S').hasMatch(value)) {
                            return 'Please enter amount in words';
                          }
                          return null;
                        },
                        icon: MaterialCommunityIcons.alphabetical,
                        hintText: 'Amount Paid in Words',
                      ),
                      const SizedBox(height: 7),
                      BuildTextInput(
                        validator: (value) {
                          if (value!.trim().isEmpty ||
                              !RegExp(r'\d').hasMatch(value)) {
                            return 'Please enter a number';
                          }
                          return null;
                        },
                        icon: MaterialCommunityIcons.numeric,
                        hintText: 'receipt no',
                      ),
                      const SizedBox(height: 7),
                      BuildTextInput(
                        type: TextInputType.phone,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'required filed';
                          }
                          return null;
                        },
                        icon: Icons.phone_android,
                        hintText: 'contact',
                      ),
                      const SizedBox(height: 7),
                      BuildTextInput(
                        type: TextInputType.phone,
                        // validator: (value) {
                        //   if (value!.trim().isEmpty ||
                        //       value.trim().length > 6 ||
                        //       !RegExp(r'\d').hasMatch(value)) {
                        //     return 'Invalid phone number';
                        //   }
                        //   return null;
                        // },
                        icon: MaterialCommunityIcons.home_outline,
                        hintText: 'H/No./Digital Address',
                      ),
                      const SizedBox(height: 7),
                      BuildTextInput(
                        type: TextInputType.text,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return 'Please enter a valid house address';
                          }
                          return null;
                        },
                        icon: Icons.home_outlined,
                        hintText: 'Place of Abode',
                      ),
                      const SizedBox(height: 7),
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
                      const SizedBox(height: 7),
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
                      const SizedBox(height: 7),
                      BuildTextInput(
                        type: TextInputType.text,
                        validator: (value) {
                          if (value!.trim().isEmpty) {
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
                            hint: Text('Choose marital status'),
                            value: initialValue.name,
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
                            onChanged: (value) {},
                            decoration: inputDecoration(),
                          ),
                        ),
                      ),
                      BuildTextInput(
                        icon: Icons.info_outline,
                        hintText: 'Others',
                      ),
                      BuildTextInput(
                        type: TextInputType.text,
                        icon: Icons.person_outline_outlined,
                        hintText: 'Name of Spouse (IF MARRIED)',
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please enter the name of your spouse";
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      controller: controller,
    );
  }
}
