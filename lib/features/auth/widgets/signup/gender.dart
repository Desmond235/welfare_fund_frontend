import 'package:church_clique/core/constants/palette.dart';
import 'package:church_clique/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:provider/provider.dart';

class SignupGenderSelection extends StatefulWidget {
  const SignupGenderSelection({super.key});

  @override
  State<SignupGenderSelection> createState() => _SignupGenderSelectionState();
}

class _SignupGenderSelectionState extends State<SignupGenderSelection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) {
        final isMale = value.isMale;
        return Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Row(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      value.toggleGender();
                      if(!isMale){
                        value.male();
                      }
                      
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      margin: const EdgeInsets.only(right: 8),
                      
                      decoration: BoxDecoration(
                        color: isMale ? Palette.textColor1 : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color:
                              isMale ? Colors.transparent : Palette.textColor1,
                        ),
                      ),
                      child: Icon(
                        MaterialCommunityIcons.account_outline,
                        color: isMale ? Colors.white : Palette.textColor1,
                      ),
                    ),
                  ),
                  Text(
                    "Male",
                    style: TextStyle(
                      fontSize: 16,
                      color: Palette.textColor1,
                    ),
                  ),
                  const SizedBox(width: 30),
                   GestureDetector(
                    onTap: () {
                      value.toggleGender();
                      if(isMale){
                        value.female();
                      }
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: !isMale ? Palette.textColor1 : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color:
                              !isMale ? Colors.transparent : Palette.textColor1,
                        ),
                      ),
                      child: Icon(
                        MaterialCommunityIcons.account_outline,
                        color: !isMale ? Colors.white : Palette.textColor1,
                      ),
                    ),
                  ),
                  Text(
                    "Female",
                    style: TextStyle(
                      fontSize: 16,
                      color: Palette.textColor1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
