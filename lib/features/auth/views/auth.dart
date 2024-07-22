import 'dart:io';

import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/core/constants/palette.dart';
import 'package:church_clique/core/service/http_service.dart';
import 'package:church_clique/features/auth/domain/sign_cache.dart';
import 'package:church_clique/features/auth/models/user_signin_model.dart';
import 'package:church_clique/features/auth/providers/auth_provider.dart';
import 'package:church_clique/features/auth/views/juice.dart';
import 'package:church_clique/features/auth/widgets/signin/build_signin.dart';
import 'package:church_clique/features/auth/widgets/signup/build_signup.dart';
import 'package:church_clique/features/auth/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  File? pickedImageFile;
  String? username;
  bool? isRememberMe;
  TextEditingController usernameController(){
    return TextEditingController(text: username);
  }

  void _loadPreferences() async{
    final prefs = await sharedPrefs;
    
    setState(() {
      username = prefs.getString('username') ?? '';
      isRememberMe = prefs.getBool('isRememberMe') ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  // void _loadPreferences() async {
  //   final prefs = await sharedPrefs;
  //   setState(() {
  //     username = prefs.getString('username');
  //     isRememberMe = prefs.getBool('isRememberMe');
  //   });
  // }

  // @override
  // void initState() {
  //   _loadPreferences();
  //   super.initState();
  // }

// this function allows users to pick an image
// and enter the enter their registration credentials
// if the user does not pick an image, he or she will be prompted to pick an image
// if the user enters a wrong or does or does not enter any information, the user will be prompted to do so
  
  @override
  void dispose() {
    usernameController().dispose();
    super.dispose();
  }
  void addCredentials() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (pickedImageFile == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please pick an image"),
      ));
      return;
    }

    _formKey.currentState!.save();

    Consumer<AuthProvider>(
      builder: (context, value, child) {
        return Http.post({
          "username": value.onSaveUsername,
          "email": value.onSaveEmail,
          "password": value.onSaveEmail
        });
      },
    );
    // Navigator.of(context).pushReplacementNamed('main');
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: KeyboardDismissOnTap(
        child: Consumer<AuthProvider>(
          builder: (context, value, child) {
            bool isSignupScreen = value.isSignUp;
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Form(
                  key: _formKey,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 355,
                          // background image
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/background.jpg',
                                ),
                                fit: BoxFit.cover),
                          ),
                          child: Container(
                            padding: const EdgeInsets.only(top: 40, left: 20),
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.75),
                            child: SafeArea(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: "Welcome to",
                                      style: TextStyle(
                                        color: Colors.yellow[700],
                                        fontSize: width < 600 ? 20 : 25,
                                        letterSpacing: 2,
                                      ),
                                      children: [
                                        TextSpan(
                                            text: " Welfare Fund,",
                                            style: TextStyle(
                                                color: Colors.yellow[600],
                                                fontSize: width < 600 ? 20 : 25,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    isSignupScreen
                                        ? 'Signup to continue'
                                        : 'Signin to continue',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SubmitButton(
                        isSignupScreen: isSignupScreen,
                        isShadow: true,
                        onTap: () {},
                      ),
                      // this adds a submit button
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.bounceInOut,
                        top: isSignupScreen ? 200 : 230,
                        child: SingleChildScrollView(
                          child: AnimatedContainer(
                            duration: const Duration(microseconds: 700),
                            curve: Curves.bounceInOut,
                            width: MediaQuery.of(context).size.width - 40,
                            height: isSignupScreen ? 500 : 260,
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                if (isSignupScreen)
                                  SignUpWidget(
                                    isSignupScreen: isSignupScreen,
                                    onPickedImage: (pickedImage) {
                                      pickedImageFile = pickedImage;
                                    },
                                  ),
                                if (!isSignupScreen)
                                  SignInWidget(
                                    controller: usernameController(),
                                    isSignupScreen: isSignupScreen,
                                    isRememberMe: isRememberMe,
                                    
                                    onChanged: (value) {
                                      setState(() {
                                        username = value;
                                      });
                                    },
                                    chkOnchanged: (value) {
                                      setState(() {
                                        isRememberMe = value!;
                                      });
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SubmitButton(
                        onTap: () async{
                          if (isSignupScreen) {
                            addCredentials();
                          } 
                        
                        
                          final prefs = await sharedPrefs;
                         prefs.setString('username', username!);
                         prefs.setBool('isRememberMe', isRememberMe!);
                         
                        },
                        isSignupScreen: isSignupScreen,
                        isShadow: false,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
