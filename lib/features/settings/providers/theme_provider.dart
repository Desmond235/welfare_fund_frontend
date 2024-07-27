import 'package:church_clique/features/theme/dark_theme.dart';
import 'package:church_clique/features/theme/light_theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData( ThemeData themeData ){
    _themeData = themeData;
    notifyListeners();
  }

  void toggleThemeMode(){
    if(_themeData == lightMode){
     themeData = darkMode; 
    }else{
      themeData = lightMode;
    }
  }
}