// import 'dart:convert';

// import 'package:church_clique/core/constants/constants.dart';
// import 'package:church_clique/features/auth/models/user_signin_model.dart';
// import 'package:flutter/material.dart';

// class SignInCache extends ChangeNotifier{
//   SignInCache._init();

//   static Future<SignIn> getUser() async{
//     var prefs = await sharedPrefs;
//     prefs.reload();
//     var response = prefs.getString('user');
//     var username = SignIn.fromJson(jsonDecode(response!));

//     return username;
    
//   }

//   static Future<void> setUser(SignIn user) async{
//     var prefs = await sharedPrefs;
//     prefs.reload();
//     var userString = jsonEncode(user.username);
//     var userBool = jsonEncode(user.rememberMe)as bool;
//     prefs.setString('user', userString);
//     prefs.setBool('remember me', userBool);
//   }

//   static Future<void> clearUser() async{
//     var prefs = await sharedPrefs;
//     prefs.remove('user');
//     prefs.reload();
//   }
// }