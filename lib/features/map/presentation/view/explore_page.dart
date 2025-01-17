import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Text(
              style: TextStyle(fontSize: 48, fontFamily: "Fondamento Regular"),
              "Explore")
        ],
      ),
    );
  }
}
