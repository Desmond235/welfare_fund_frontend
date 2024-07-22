import 'package:church_clique/features/auth/domain/sign_cache.dart';
import 'package:church_clique/features/auth/models/user_signin_model.dart';
import 'package:flutter/material.dart';

class SignInProvider extends ChangeNotifier {
  String username = '';
  bool rememberMe = false;
  bool isSignUp = true;


  void checkIsRememberMe(bool value){
    rememberMe = value;
    notifyListeners();
  }

  void toggleLogin(){
    isSignUp = false;
    notifyListeners();
  }

  
}
