import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier{
   bool _isSignUp = true;
  static bool _isRememberMe = false;
  bool _isMale = false;
  String  onSaveUsername = '';
  String onSavePassword = '';
  String onSaveEmail = '';

  void toggleLogin(){
    _isSignUp = false;
    notifyListeners();
  }
  void toggleSignup(){
    _isSignUp = true;
    notifyListeners();
  }

  void toggleGender(){
    _isMale =!_isMale;
    notifyListeners();
  }
  void checkIsRememberMe(bool value){
    _isRememberMe = value;
    notifyListeners();
  }
  void saveUsername(String? value){
    onSaveUsername = value!;
  }
  void  saveEmail(String? value){
    onSaveEmail = value!;
  }
  void savePassword(String? value){
    onSavePassword = value!;
  }
   bool get isSignUp => _isSignUp;
  bool get isRememberMe => _isRememberMe;
  bool get isMale => _isMale;
}
