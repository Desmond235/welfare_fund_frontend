
import 'package:church_clique/core/constants/constants.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends ChangeNotifier{
   bool _isOnboarded = false;
  bool get  onboarded => _isOnboarded;

//  sets the onboarding sate 
  void setOnboarded(bool value){
    _isOnboarded = value;
    saveOnboardingState();
    notifyListeners();
  }
  
  // save onboarding state to shared preferences
  void saveOnboardingState() async{
    final prefs = await sharedPrefs;
    prefs.setBool('isOnboarded', _isOnboarded);
  }

  void removeOnboardingState() async{
    final prefs = await sharedPrefs;
    prefs.remove('isOnboarded');
  }

  void getOnboardingState() async{
    final prefs = await sharedPrefs;
    _isOnboarded = prefs.getBool('isOnboarded')?? false;
    notifyListeners();
  }

}