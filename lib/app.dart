import 'package:flutter/material.dart';
import 'package:worldreader/view/on_boarding_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: OnBoardingScreen(),
      // home: SignUpPage(),
    );
  }
}
