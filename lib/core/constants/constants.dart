import 'package:church_clique/core/base/main/main_page_provider.dart';
import 'package:church_clique/core/base/main/mainscreen.dart';
import 'package:church_clique/core/constants/palette.dart';
import 'package:church_clique/features/auth/providers/auth_provider.dart';
import 'package:church_clique/features/auth/providers/sign_provider.dart';
import 'package:church_clique/features/auth/views/auth.dart';
import 'package:church_clique/features/auth/views/juice.dart';
import 'package:church_clique/features/form/data/data.dart';
import 'package:church_clique/features/form/views/form_screen.dart';
import 'package:church_clique/features/form/views/fourth_form_screen.dart';
import 'package:church_clique/features/form/views/second_form.dart';
import 'package:church_clique/features/form/views/third_form_screen.dart';
import 'package:church_clique/features/home/screens/home_screeb.dart';
import 'package:church_clique/features/onboard/provider/onboard_state_page.dart';
import 'package:church_clique/features/payment/views/payment_screen.dart';
import 'package:church_clique/features/settings/providers/theme_provider.dart';
import 'package:church_clique/features/settings/views/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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
  ChangeNotifierProvider(create: (context) => ThemeProvider()),
  ChangeNotifierProvider(create: (context) => OnboardStatePage()),
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

Map<String, Widget Function(BuildContext)> routes = {
  'juice': (context) => Juice(),
  'payment': (context) => PaymentScreen(),
  'main': (context) => MainScreen(),
  'settings': (context) => SettingsScreen(),
  'auth': (context) => AuthScreen(),
  'second_form': (context) => SecondForm(),
  'third_form': (context) => ThirdFormScreen(),
  'fourth_form': (context) => FourthFormScreen(),
  'form_screen': (context) => FormScreen(),
};

List<Widget> kOnboardPage = [
  FormScreen(),
  SecondForm(),
  ThirdFormScreen(),
  FourthFormScreen()
];
 
  GetData membership = GetData();
 Map<String, dynamic> membershipData = {
    'fullName': membership.fullName,
    'dateOfBirth': membership.dateOfBirth,
    'dateOfRegistration': membership.dateOfRegistration,
    'amountPaid': membership.amountPaid,
    'amountPaidInWords': membership.amountInWords,
    'receiptNo': membership.receiptNumber,
    'contact': membership.contact,
    'houseNo': membership.houseNo,
    'PlaceOfAbode' : membership.placeOfAbode,
    'landmark': membership.landmark,
    'homeTown': membership.homeTown,
    'region': membership.region,
    'MaritalStatus': membership.maritalStatus,
    'others': membership.others,
    'nameOfSpouse': membership.nameOfSpouse,
    "LifeStatus": membership.lifeStatus,
    'NumberOfChildren': membership.numberOfChildren,
    'namesOfChildren': membership.namesOfChildren,
    'occupation': membership.occupation,
    'fatherName': membership.fatherName,
    'fLifeStatus': membership.fLifeStatus,
    'motherName': membership.motherName,
    'mLifeStatus' : membership.mLifeStatus,
    'nextOfKin' : membership.nameOfNextKin,
    'nextOfKinContact' : membership.nextOfKinContact,
    'classLeader' : membership.classLeader,
    'classLeaderContact' : membership.classLeaderContact,
    'orgOfMember' : membership.orgOfMember,
    'orgLeaderContact' : membership.orgLeaderContact
 };


 