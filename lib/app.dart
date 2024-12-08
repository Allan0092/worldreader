import 'package:flutter/material.dart';
import 'package:worldreader/view/login_page.dart';
import 'package:worldreader/view/sign_up_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: LoginPage(),
      home: SignUpPage(),
    );
  }
}
