import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier{
   bool _isSignUp = true;

  bool _isMale = true;
  String  onSaveUsername = '';
  String onSavePassword = '';
  String onSaveEmail = '';
  String onSaveContact = '';
  String gender = '';

  // General provider
  void toggleLogin(){
    _isSignUp = false;
    notifyListeners();
  }
  void toggleSignup(){
    _isSignUp = true;
    notifyListeners();
  }

  // sign up providers

  void toggleGender(){
    _isMale =!_isMale;
    notifyListeners();
  }

  void saveContact(String? value){
    onSaveContact = value!;
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
  void male(){
      gender = "Male";
      print(gender);
      notifyListeners();
  }
  void female(){
      gender = "Female";
      print(gender);
      notifyListeners();
  }
   bool get isSignUp => _isSignUp;
  bool get isMale => _isMale;
}
