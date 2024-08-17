import 'dart:io';

import 'package:church_clique/core/components/dialog_box.dart';
import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/core/constants/palette.dart';
import 'package:church_clique/core/service/http_service.dart';
import 'package:church_clique/core/service/signin_service.dart';
import 'package:church_clique/features/auth/models/user_signin_model.dart';
import 'package:church_clique/features/auth/providers/auth_provider.dart';
import 'package:church_clique/features/auth/providers/sign_provider.dart';
import 'package:church_clique/features/auth/widgets/signin/build_signin.dart';
import 'package:church_clique/features/auth/widgets/signup/build_signup.dart';
import 'package:church_clique/features/auth/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:http/http.dart' as http;

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
  final passwordController = TextEditingController();
  bool _isSending = true;

  http.Response? response;

 
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
  }
// this function allows users to pick an image
// and enter the enter their registration credentials
// if the user does not pick an image, he or she will be prompted to pick an image
// if the user enters a wrong or does or does not enter any information, the user will be prompted to do so

  post() {}
  void addItem() async {
    final data = {
      "username": Provider.of<AuthProvider>(context, listen: false)
          .onSaveUsername
          .trim(),
      "email":
          Provider.of<AuthProvider>(context, listen: false).onSaveEmail.trim(),
      "contact": Provider.of<AuthProvider>(context, listen: false)
          .onSaveContact
          .trim(),
      "password": Provider.of<AuthProvider>(context, listen: false)
          .onSavePassword
          .trim(),
    };
    if(pickedImageFile == null){
      return ;
    }
    Http.post(data, context,file: pickedImageFile!);
    
  }

  void signIn() async {
    _formKey.currentState!.save();

    final provider = Provider.of<SignInProvider>(context, listen: false);
    final signIn = SignIn();
    
    setState(() {
      _isSending = true;
    });
    SigninService.login(
      provider.username.trim(),
      provider.password.trim(),

      signIn.userId,
      context,
      (
        getRes,
      ) {
        response = getRes;
        if (response!.statusCode == 401 || response!.statusCode == 400) {
          setState(() {
            _isSending = true;
          });
        }

        if (response!.statusCode == 200) {
          Navigator.of(context).pushReplacementNamed('main');
        }
      },
    );
    setState(() {
      _isSending = false;
    });

    // Provider.of<OnboardingPage>(context,listen: false).removeOnboardingState();
    Provider.of<SignInProvider>(context, listen: false).setSignIn(true);
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
    }

    _formKey.currentState!.save();
    addItem();

    // Navigator.of(context).pushReplacementNamed('main');
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (value, result) {
        dialogBox(context);
      },
      child: Scaffold(
        backgroundColor: Palette.backgroundColor,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: systemUiOverlayStyle,
          child: SingleChildScrollView(
            child: KeyboardDismissOnTap(
              child: Consumer<AuthProvider>(
                builder: (context, value, child) {
                  bool isSignupScreen = value.isSignUp;
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 0.96,
                    child: Form(
                      key: _formKey,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              child: Container(
                                height: 355,
                                // background image
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/logo.png',
                                      ),
                                      fit: BoxFit.cover),
                                ),
                                child: Container(
                                  padding:
                                      const EdgeInsets.only(top: 40, left: 20),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.8),
                                  child: SafeArea(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // color: priCol(context).withOpacity(0.4),
                                          child: RichText(
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
                                                        color:
                                                            Colors.yellow[600],
                                                        fontSize: width < 600
                                                            ? 20
                                                            : 25,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          isSignupScreen
                                              ? 'Signup to continue'
                                              : 'Signin to continue',
                                          style: const TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SubmitButton(
                            isSending: _isSending,
                            isSignupScreen: isSignupScreen,
                            isShadow: true,
                            onTap: () {},
                          ),
                          // this adds a submit button
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 700),
                            curve: Curves.bounceInOut,
                            top: isSignupScreen ? 180 : 230,
                            child: AnimatedContainer(
                              duration: const Duration(microseconds: 700),
                              curve: Curves.bounceInOut,
                              width: MediaQuery.of(context).size.width - 40,
                              height: isSignupScreen ? 565 : 260,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                                      // FIXME: getTextBefore on inactive input connection issue
                                      passwordController: passwordController,
                                      isSignupScreen: isSignupScreen,
                                      isRememberMe: isRememberMe,
                                      onChanged: (value) async {
                                        setState(() {
                                          username = value;
                                        });
                                      },
                                      chkOnchanged: (value) async {
                                        setState(() {
                                          isRememberMe = value!;
                                        });
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ),
                          SubmitButton(
                            isSending: _isSending,
                            onTap: () async {
                              if (isSignupScreen) {
                                addCredentials();
                              } else {
                                signIn();
                              }
                            },
                            isSignupScreen: isSignupScreen,
                            isShadow: false,
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
