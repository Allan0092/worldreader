import 'package:flutter/material.dart';
import 'package:worldreader/core/app_theme/app_theme.dart';
import 'package:worldreader/features/auth/presentation/view/login_page.dart';
import 'package:worldreader/features/auth/presentation/view/sign_up_page.dart';
import 'package:worldreader/features/home/presentation/view/dashboard.dart';
import 'package:worldreader/features/splash/presentation/view/on_boarding_screen.dart';

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
