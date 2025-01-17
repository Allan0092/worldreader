import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Text(
              style: TextStyle(fontSize: 48, fontFamily: "Fondamento Regular"),
              "Library"),
          Text("nothing to read here...")
        ],
      ),
    );
  }
}
