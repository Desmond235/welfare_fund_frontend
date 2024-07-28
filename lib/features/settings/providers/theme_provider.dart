import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/features/theme/dark_theme.dart';
import 'package:church_clique/features/theme/light_theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData = lightMode;
  
  bool isDarkTheme = false;

  


  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;
  

   void getDarkTheme() async{
    final prefs = await sharedPrefs;
    isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    notifyListeners();
  }

  void saveDarkTheme() async {
    final prefs = await sharedPrefs;
    prefs.setBool('isDarkTheme', isDarkTheme);
  }
  void removeDarkTheme() async {
    final prefs = await sharedPrefs;
    prefs.remove('isDarkTheme');
  }

  
  set setTheme(bool value){
    isDarkTheme = value;
    saveDarkTheme();
    notifyListeners();
  }

  set themeData( ThemeData themeData ){
    _themeData = themeData;
    notifyListeners();
  }
  

  void toggleThemeMode(){
    if(_themeData == lightMode){
     themeData = darkMode; 
     setTheme = true;
     
    }else{
      themeData = lightMode;
      setTheme = false;
      removeDarkTheme();
    }
  }
}