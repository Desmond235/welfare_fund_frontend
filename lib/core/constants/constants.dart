import 'package:church_clique/core/base/main/main_page_provider.dart';
import 'package:church_clique/core/base/main/mainscreen.dart';
import 'package:church_clique/core/constants/palette.dart';
import 'package:church_clique/features/auth/providers/auth_provider.dart';
import 'package:church_clique/features/auth/providers/sign_provider.dart';
import 'package:church_clique/features/auth/views/auth.dart';
import 'package:church_clique/features/auth/views/juice.dart';
import 'package:church_clique/features/form/data/data.dart';
import 'package:church_clique/features/form/models/membership_model.dart';
import 'package:church_clique/features/form/views/form_screen.dart';
import 'package:church_clique/features/form/views/fourth_form_screen.dart';
import 'package:church_clique/features/form/views/second_form.dart';
import 'package:church_clique/features/form/views/third_form_screen.dart';
import 'package:church_clique/features/home/screens/home_screeb.dart';
import 'package:church_clique/features/onboard/provider/onboard_state_page.dart';
import 'package:church_clique/features/onboard/provider/onboarding_provider.dart';
import 'package:church_clique/features/onboard/views/onboard.dart';
import 'package:church_clique/features/onboard/views/welcome_screen.dart';
import 'package:church_clique/features/payment/data/data.dart';
import 'package:church_clique/features/payment/views/payment_screen.dart';
import 'package:church_clique/features/settings/providers/image_provider.dart';
import 'package:church_clique/features/settings/providers/theme_provider.dart';
import 'package:church_clique/features/settings/views/settings_screen.dart';
import 'package:church_clique/features/transation_details/views/transaction_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

final KMainPages = [HomeScreen(), PaymentScreen(), TransactionDetailsScreen()];

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
  ChangeNotifierProvider(create: (context) => GetData()),
  ChangeNotifierProvider(create: (context) => OnboardingPage()),
  ChangeNotifierProvider(create: (context) => ImagePathProvider()),
  ChangeNotifierProvider(create: (context) => AuthorizationUrl())
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
  'onboard': (context) => OnboardScreen(),
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

String fullNameController = '';
String dateOfBirthController = '';
String dateOfRegistrationController = '';
String contactController = '';
String houseNumberController = '';
String placeOfAbodeController = '';
String landMarkController = '';
String homeTownController = '';
String regionController = '';
String maritalStatusController = '';
String nameOfSpouseController = '';
String lifeStatusController = '';
String occupationController = '';
String fatherNameController = '';
String fatherLifeStatusController = '';
String motherNameController = '';
String motherLifeStatusController = '';
String nextOfKinController = '';
String nextOfKinContactController = '';
String classLeaderController = '';
String classLeaderContactController = '';
String organizationOfMemberController = '';
String orgLeaderContactController = '';

 Map<String, dynamic> memberData = {
  'fullName': fullNameController,
  'dateOfBirth': dateOfBirthController,
  'dateOfRegistration': dateOfRegistrationController,
  'contact': contactController,
  'houseNumber': houseNumberController,
  'placeOfAbode': placeOfAbodeController,
  'landmark': landMarkController,
  'homeTown': homeTownController,
 'region': regionController,
 'maritalStatus': maritalStatusController,
  'nameOfSpouse': nameOfSpouseController,
  'lifeStatus': lifeStatusController,
  'occupation': occupationController,
  'fatherName': fatherNameController,
  'fatherLifeStatus': fatherLifeStatusController,
 'motherName': motherNameController,
 'motherLifeStatus': motherLifeStatusController,
  'nextOfKin': nextOfKinController,
  'nextOfKinContact': nextOfKinContactController,
  'classLeader': classLeaderController,
  'classLeaderContact': classLeaderContactController,
  'organizationOfMember': organizationOfMemberController,
  'orgLeaderContact': orgLeaderContactController,
};
