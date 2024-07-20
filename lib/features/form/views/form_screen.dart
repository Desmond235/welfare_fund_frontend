import 'package:church_clique/core/components/input_control.dart';
import 'package:church_clique/core/constants/palette.dart';
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
  @override
  Widget build(BuildContext context) {
    AdvancedDrawerController controller = AdvancedDrawerController();
    return HomeDrawer(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildTextInput(
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
                    DateTimePickerWidget(),
                    DateTimePickerWidget()
                  ],
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

class DateTimePickerWidget extends StatelessWidget {
  const DateTimePickerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.67,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Date of Birth',
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
            onPressed: () {},
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
