import 'package:church_clique/features/auth/domain/sign_cache.dart';
import 'package:church_clique/features/auth/models/user_signin_model.dart';
import 'package:flutter/material.dart';

class SignInProvider extends ChangeNotifier {
  String username = '';
 String password = '';
  
  void saveUsername(String? value){
    username = value!;
  }
  
  void savePassword(String? value){
    password = value!;
  }
}
