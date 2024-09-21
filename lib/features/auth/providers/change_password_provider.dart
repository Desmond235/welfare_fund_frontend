import 'package:flutter/material.dart';

class ChangePasswordProvider  extends ChangeNotifier{
  bool? _isChangePassword ;
  bool _isForgetPassword = false;

  bool get isChangedPassword => _isChangePassword!;
  bool get isForgetPassword => _isForgetPassword;


 void setIsChangePassword(bool value){
  _isChangePassword = value;
  notifyListeners();
 }

void setForgetPassword (bool value){
  _isForgetPassword = value;
  notifyListeners();
 
}

}