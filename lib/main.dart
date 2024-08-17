import 'package:church_clique/core/base/main/mainscreen.dart';
import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/features/auth/providers/sign_provider.dart';
import 'package:church_clique/features/auth/views/auth.dart';
import 'package:church_clique/features/form/views/form_screen.dart';
import 'package:church_clique/features/onboard/provider/onboarding_provider.dart';
import 'package:church_clique/features/onboard/views/onboard.dart';
import 'package:church_clique/features/onboard/views/welcome_screen.dart';
import 'package:church_clique/features/settings/providers/theme_provider.dart';
import 'package:church_clique/features/theme/dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  systemNavBarColor;
  await dotenv.load(fileName: '.env');
  runApp(
    MultiProvider(
      providers: multiProviders,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeProvider>(context);
    themeState.getDarkTheme();

    final onboardState = Provider.of<OnboardingPage>(context);
    onboardState.getOnboardingState();

    final signinPageState = Provider.of<SignInProvider>(context);
    signinPageState.getSigninState();
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      // themeMode: themeState.isDarkMode? ThemeMode.dark : ThemeMode.light,
      darkTheme: darkMode,
      themeMode: themeState.isDarkTheme
          ? ThemeMode.dark
          : !themeState.isDarkTheme
              ? ThemeMode.light
              : ThemeMode.system,
      theme: Provider.of<ThemeProvider>(context).themeData,
      // home: signinPageState.isSignin ? MainScreen() : AuthScreen(),
      home:  const MainScreen(),
      // home: onboardState.onboarded
      //     ? const AuthScreen()
      //     // : signinPageState.isSignin
      //     //     ? MainScreen()
      //     //     : !signinPageState.isSignin
      //             : const WelcomeScreen(),
      // home: const ThirdFormScreen(),
      routes: routes,
    );
  }
}
