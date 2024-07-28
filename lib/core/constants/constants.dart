import 'package:church_clique/core/base/main/main_page_provider.dart';
import 'package:church_clique/core/constants/palette.dart';
import 'package:church_clique/features/auth/providers/auth_provider.dart';
import 'package:church_clique/features/auth/providers/sign_provider.dart';
import 'package:church_clique/features/form/views/form_screen.dart';
import 'package:church_clique/features/home/screens/home_screeb.dart';
import 'package:church_clique/features/payment/views/payment_screen.dart';
import 'package:church_clique/features/settings/providers/theme_provider.dart';
import 'package:church_clique/features/settings/views/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

final KMainPages = [HomeScreen(), PaymentScreen(), FormScreen()];

Color priCol(BuildContext context) {
  return Theme.of(context).colorScheme.primary;
}

final Future<SharedPreferences> sharedPrefs = SharedPreferences.getInstance();

List<SingleChildWidget> multiProviders = [
  ChangeNotifierProvider(create: (context) => AuthProvider()),
  ChangeNotifierProvider(create: (context) => MainPageProvider()),
  ChangeNotifierProvider(create: (context) => SignInProvider()),
  ChangeNotifierProvider(create: (context) => ThemeProvider())
];

final systemNavBarColor = SystemChrome.setSystemUIOverlayStyle(
  SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    // systemNavigationBarColor: Palette.backgroundColor,
    // systemNavigationBarIconBrightness: Brightness.dark,
    // systemNavigationBarDividerColor: Colors.transparent
  ),
);

final systemUiOverlayStyle = SystemUiOverlayStyle(
    systemNavigationBarColor: Palette.backgroundColor,
    systemNavigationBarIconBrightness: Brightness.dark,
    systemNavigationBarDividerColor: Colors.transparent);

SystemUiOverlayStyle mainSystemUiOverlayStyle(BuildContext context) {
  final darkTheme =
      Provider.of<ThemeProvider>(context, listen: false).isDarkTheme;
  final darkMode =
      Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
  return SystemUiOverlayStyle(
      systemNavigationBarColor:
          darkMode || darkTheme ? Colors.black.withOpacity(0.85) : Colors.white,
      systemNavigationBarIconBrightness:
          darkMode || darkTheme ? Brightness.light : Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent);
}

dialogBox(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: Icon(Icons.exit_to_app),
          content: Text(
            "Are you sure you want to exit?",
            style: TextStyle(fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                SystemNavigator.pop();
                // canPop = true;
              },
              child: Text('Yes'),
            ),
          ],
        );
      });
}
