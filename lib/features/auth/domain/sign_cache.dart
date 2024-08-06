import 'dart:convert';

import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/features/auth/models/user_model.dart';
import 'package:church_clique/features/auth/models/user_signin_model.dart';
import 'package:flutter/material.dart';

class SignInCache  extends ChangeNotifier{
  SignInCache._init();

  int userId =0;

  void getUserId() async{
    var prefs = await sharedPrefs;
    prefs.reload();
    userId = prefs.getInt('userId') ?? 0; 

    
  }

  void saveUserId(int id) async{
    var prefs = await sharedPrefs;
    prefs.reload();
    userId = id;
    prefs.setInt('userId', userId);
  }

  static Future<void> clearUserId() async{
    var prefs = await sharedPrefs;
    prefs.remove('user');
    prefs.reload();
  }
}