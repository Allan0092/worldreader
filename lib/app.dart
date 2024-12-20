import 'package:flutter/material.dart';
import 'package:worldreader/core/app_theme/app_theme.dart';
import 'package:worldreader/view/dashboard.dart';
import 'package:worldreader/view/login_page.dart';
import 'package:worldreader/view/on_boarding_screen.dart';
import 'package:worldreader/view/sign_up_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: getApplicationTheme(),
      // home: const OnBoardingScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => const OnBoardingScreen(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/dashboard': (context) => const Dashboard(),
      },
    );
  }
}
