import 'package:flutter/material.dart';
import 'package:worldreader/core/app_theme/app_theme.dart';
import 'package:worldreader/view/on_boarding_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: getApplicationTheme(),
      home: const OnBoardingScreen(),
      // home: SignUpPage(),
    );
  }
}
