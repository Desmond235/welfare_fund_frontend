import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  set themeMode( ThemeMode themeMode ){
    _themeMode = themeMode;
    notifyListeners();
  }

  void toggleThemeMode(){
    if(_themeMode == ThemeMode.light){
     themeMode = ThemeMode.dark; 
    }else{
      themeMode = ThemeMode.light;
    }
  }
}