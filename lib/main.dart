import 'package:church_clique/core/constants/constants.dart';
import 'package:church_clique/features/auth/views/auth.dart';
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
      home: const AuthScreen(),
      routes: routes,
    );
  }
}
