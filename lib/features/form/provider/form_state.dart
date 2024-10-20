import 'package:church_clique/core/constants/constants.dart';
import 'package:flutter/material.dart';

class MemFormState extends ChangeNotifier{
  bool _isFillMemForm = false;
  int? _userId;
  


  bool get isFillMemFrom => _isFillMemForm;
  int get userId => _userId ?? 0;

  void setUserId(int value){
    _userId = value;
    
    notifyListeners();
  }

  void saveUserId() async{
    final prefs = await sharedPrefs;
    prefs.setInt('userId', _userId!);
  }

void getUserId() async{
  final prefs =await sharedPrefs;
  _userId = prefs.getInt('userId');
  notifyListeners();
}
  void setFormState (bool value){
    _isFillMemForm = value;
    saveFormState();
    notifyListeners();
  }

  void saveFormState() async {
    final prefs = await sharedPrefs;
    prefs.setBool('isFillMemForm', _isFillMemForm);
  }

  void getFormState() async {
    final prefs = await sharedPrefs;
    _isFillMemForm = prefs.getBool('isFillMemForm') ?? false;
    notifyListeners();
  }
}