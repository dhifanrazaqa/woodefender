import 'package:flutter/material.dart';
import 'package:woodefender/screens/community/home_comm_screen.dart';
import 'package:woodefender/screens/home_screen.dart';
import 'package:woodefender/screens/profile_screen.dart';
import 'package:woodefender/services/auth_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
    required this.pageIndex,
  });
  final pageIndex;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
    int currentPageIndex = 0;

  @override
  void initState() {
    currentPageIndex = widget.pageIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.black,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          shadowColor: Colors.amber,
          indicatorColor: Colors.white,
          selectedIndex: currentPageIndex,
          destinations: <Widget>[
            const NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined, color: Colors.white),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Image.asset(
                'assets/images/logo-bottom.png',
                height: 48
              ),
              label: 'WooDefender',
            ),
            const NavigationDestination(
              selectedIcon: Icon(Icons.account_circle),
              icon: Icon(Icons.account_circle_outlined, color: Colors.white,),
              label: 'Profile',
            ),
          ],
        ),
        body: <Widget>[
          CommunityScreen(),
          HomeScreen(),
          ProfileScreen()
        ][currentPageIndex],
      ),
    );
  }
}