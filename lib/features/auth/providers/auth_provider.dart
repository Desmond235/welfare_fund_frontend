import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier{
   bool _isSignUp = true;
  static bool _isRememberMe = false;
  bool _isMale = false;

  void toggleLogin(){
    _isSignUp = false;
    notifyListeners();
  }
  void toggleSignup(){
    _isSignUp = true;
    notifyListeners();
  }
  void toggleRememberMe(){
    _isRememberMe =!_isRememberMe;
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
   bool get isSignUp => _isSignUp;
  bool get isRememberMe => _isRememberMe;
  bool get isMale => _isMale;
}
