
import 'package:church_clique/features/home/screens/home_screeb.dart';
import 'package:church_clique/features/payment/views/payment_screen.dart';
import 'package:church_clique/features/settings/views/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final KMainPages = [
  HomeScreen(),
  PaymentScreen(),
  ProfileScreen()
];

Color priCol(BuildContext context){
  return Theme.of(context).colorScheme.primary;
}

final Future<SharedPreferences> prefs =   SharedPreferences.getInstance();