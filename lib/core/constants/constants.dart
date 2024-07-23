import 'package:church_clique/core/base/main/main_page_provider.dart';
import 'package:church_clique/core/constants/palette.dart';
import 'package:church_clique/features/auth/providers/auth_provider.dart';
import 'package:church_clique/features/auth/providers/sign_provider.dart';
import 'package:church_clique/features/home/screens/home_screeb.dart';
import 'package:church_clique/features/payment/views/payment_screen.dart';
import 'package:church_clique/features/settings/views/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

final KMainPages = [HomeScreen(), PaymentScreen(), ProfileScreen()];

Color priCol(BuildContext context) {
  return Theme.of(context).colorScheme.primary;
}

final Future<SharedPreferences> sharedPrefs = SharedPreferences.getInstance();

List<SingleChildWidget> multiProviders = [
  ChangeNotifierProvider(create: (context) => AuthProvider()),
  ChangeNotifierProvider(create: (context) => MainPageProvider()),
  ChangeNotifierProvider(create: (context) => SignInProvider()),
];

final systemNavBarColor =   SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      // systemNavigationBarColor: Palette.backgroundColor,
      // systemNavigationBarIconBrightness: Brightness.dark,
      // systemNavigationBarDividerColor: Colors.transparent
    ),
  );

final systemUiOverlayStyle = SystemUiOverlayStyle(
   systemNavigationBarColor: Palette.backgroundColor,
   systemNavigationBarIconBrightness: Brightness.dark
);
