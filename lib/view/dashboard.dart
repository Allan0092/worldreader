import 'package:flutter/material.dart';
import 'package:worldreader/view/explore_page.dart';
import 'package:worldreader/view/library_page.dart';
import 'package:worldreader/view/store_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 1;
  List<Widget> lstBottomScreen = [
    const ExplorePage(),
    const LibraryPage(),
    const StorePage(),
  ];

  void onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Row(
          textDirection: TextDirection.rtl,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.eMLmzmhAqRMxUZad3zXE5QHaHa%26pid%3DApi&f=1&ipt=4d684bca79e7e51c84bd7acf813a524648301e4918c79fd8cbe2652740929eea&ipo=images"),
            ),
          ],
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(2.0),
            child: Container(
              color: Colors.white,
              height: 1.0,
            )),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: lstBottomScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF222222),
        selectedItemColor: Colors.blue,
        selectedIconTheme: const IconThemeData(
          color: Colors.blue,
        ),
        unselectedItemColor: Colors.white,
        selectedFontSize: 16,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.explore,
                color: Colors.white,
              ),
              label: 'Explore'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.folder_copy_rounded,
                color: Colors.white,
              ),
              label: 'Library'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.store,
                color: Colors.white,
              ),
              label: 'Store'),
        ],
        currentIndex: _selectedIndex,
        onTap: onBottomNavTapped,
      ),
    );
  }
}
