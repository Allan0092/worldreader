import 'package:flutter/material.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Text(
              style: TextStyle(fontSize: 48, fontFamily: "Fondamento Regular"),
              "Store")
        ],
      ),
    );
  }
}
