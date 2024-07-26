import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/core/constants/palette.dart';
import 'package:church_clique/features/auth/views/auth.dart';
import 'package:church_clique/features/auth/views/juice.dart';
import 'package:church_clique/core/base/main/mainscreen.dart';
import 'package:church_clique/features/form/views/form_screen.dart';
import 'package:church_clique/features/payment/views/payment_screen.dart';
import 'package:church_clique/features/settings/providers/theme_provider.dart';
import 'package:church_clique/features/settings/views/settings_screen.dart';
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
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        themeMode: Provider.of<ThemeProvider>(context, listen: false).themeMode,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AuthScreen(),
        routes: {
          'juice': (context) => Juice(),
          'payment': (context) => PaymentScreen(),
          'main': (context) => MainScreen(),
          'settings': (context) => SettingsScreen(),
          'auth': (context) => AuthScreen(),
        });
  }
}
