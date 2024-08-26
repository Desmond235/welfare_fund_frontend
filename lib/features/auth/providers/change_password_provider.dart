import 'package:flutter/material.dart';

class ChangePasswordProvider  extends ChangeNotifier{
  bool? _isChangePassword ;
  bool get isChangedPassword => _isChangePassword!;

 void setIsChangePassword(bool value){
  _isChangePassword = value;
  notifyListeners();
 }

}