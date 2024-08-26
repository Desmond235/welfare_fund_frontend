import 'package:church_clique/core/base/main/main_page_provider.dart';
import 'package:church_clique/core/base/main/mainscreen.dart';
import 'package:church_clique/core/constants/palette.dart';
import 'package:church_clique/features/auth/providers/auth_provider.dart';
import 'package:church_clique/features/auth/providers/change_password_provider.dart';
import 'package:church_clique/features/auth/providers/sign_provider.dart';
import 'package:church_clique/features/auth/views/auth.dart';
import 'package:church_clique/features/auth/views/chang_password.dart';
import 'package:church_clique/features/auth/widgets/verify_email.dart';
import 'package:church_clique/features/form/data/data.dart';
import 'package:church_clique/features/form/provider/form_state.dart';
import 'package:church_clique/features/form/views/form_screen.dart';
import 'package:church_clique/features/form/views/fourth_form_screen.dart';
import 'package:church_clique/features/form/views/second_form.dart';
import 'package:church_clique/features/form/views/third_form_screen.dart';
import 'package:church_clique/features/home/screens/home_screeb.dart';
import 'package:church_clique/features/onboard/provider/onboard_state_page.dart';
import 'package:church_clique/features/onboard/provider/onboarding_provider.dart';
import 'package:church_clique/features/onboard/views/onboard.dart';
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

final KMainPages = [const HomeScreen(), const PaymentScreen(), const TransactionDetailsScreen()];

Color priCol(BuildContext context) {
  return Theme.of(context).colorScheme.primary;
}

final Future<SharedPreferences> sharedPrefs = SharedPreferences.getInstance();

List<SingleChildWidget> multiProviders = [
  ChangeNotifierProvider(create: (context) => AuthProvider()),
  ChangeNotifierProvider(create: (context) => MemFormState()),
  ChangeNotifierProvider(create: (context) => MainPageProvider()),
  ChangeNotifierProvider(create: (context) => SignInProvider()),
  ChangeNotifierProvider(create: (context) => ThemeProvider()),
  ChangeNotifierProvider(create: (context) => OnboardStatePage()),
  ChangeNotifierProvider(create: (context) => GetData()),
  ChangeNotifierProvider(create: (context) => OnboardingPage()),
  ChangeNotifierProvider(create: (context) => ImagePathProvider()),
  ChangeNotifierProvider(create: (context) => AuthorizationUrl()),
  ChangeNotifierProvider(create: (context) => ChangePasswordProvider())
];

final systemNavBarColor = SystemChrome.setSystemUIOverlayStyle(
  const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    // systemNavigationBarColor: Palette.backgroundColor,
    // systemNavigationBarIconBrightness: Brightness.dark,
    // systemNavigationBarDividerColor: Colors.transparent
  ),
);

const systemUiOverlayStyle = SystemUiOverlayStyle(
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
  'payment': (context) => const PaymentScreen(),
  'main': (context) => const MainScreen(),
  'settings': (context) => const SettingsScreen(),
  'auth': (context) => const AuthScreen(),
  'otp': (context) => const VerifyEmail(),
  'onboard': (context) => const OnboardScreen(),
  'second_form': (context) => const SecondForm(),
  'third_form': (context) => const ThirdFormScreen(),
  'fourth_form': (context) => const FourthFormScreen(),
  'form_screen': (context) => const FormScreen(),
  'password' : (context) => const ChangePasswordScreen(),
};

List<Widget> kOnboardPage = [
  const FormScreen(),
  const SecondForm(),
  const ThirdFormScreen(),
  const FourthFormScreen()
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

 
