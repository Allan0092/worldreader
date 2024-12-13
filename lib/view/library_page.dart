import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Row(
            textDirection: TextDirection.rtl,
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.eMLmzmhAqRMxUZad3zXE5QHaHa%26pid%3DApi&f=1&ipt=4d684bca79e7e51c84bd7acf813a524648301e4918c79fd8cbe2652740929eea&ipo=images"),
              ),
            ],
          )),
      bottomNavigationBar: Container(
        color: Colors.black,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                child: Text(style: TextStyle(color: Colors.white), "Explore")),
            Container(
              child: Text(style: TextStyle(color: Colors.white), "Library"),
            ),
            Container(
              child: Text(style: TextStyle(color: Colors.white), "Store"),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Text(
              style: TextStyle(fontSize: 48, fontFamily: "Fondamento"),
              "Library")
        ],
      ),
    );
  }
}
