import 'package:church_clique/core/constants/constants.dart';
import 'package:flutter/material.dart';

class MemFormState extends ChangeNotifier{
  bool _isFillMemForm = false;
  bool get isFillMemFrom => _isFillMemForm;

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