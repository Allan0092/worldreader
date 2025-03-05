import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worldreader/features/home/presentation/view_model/home_cubit.dart';
import 'package:worldreader/features/home/presentation/view_model/home_state.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late String _currAppBar;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Row(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontFamily: "Fondamento Regular"),
            ),
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
      body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        return state.views.elementAt(state.selectedIndex);
      }),
      bottomNavigationBar:
          BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        return BottomNavigationBar(
          backgroundColor: const Color(0xFF222222),
          selectedItemColor: Colors.blue,
          selectedIconTheme: const IconThemeData(
            color: Colors.blue,
          ),
          unselectedItemColor: Colors.white,
          selectedFontSize: 16,
          items: const <BottomNavigationBarItem>[
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
          currentIndex: state.selectedIndex,
          onTap: (index) {
            context.read<HomeCubit>().onTabTapped(index);
          },
          // onTap: onBottomNavTapped,
        );
      }),
    );
  }
}
