import 'package:flutter/material.dart';
import 'package:voting_app/screens/home/homeNav.dart';
import 'package:voting_app/screens/profile/profile.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int _currentINdex = 0;

  @override
  Widget build(BuildContext context) {
    final _page = <Widget>[
      homeNav(),
      profile(),
    ];
    final _bottomNavBarItem = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 30,
            color: Colors.black,
          ),
          label: 'Home'),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            size: 30,
            color: Colors.black,
          ),
          label: 'Account'),
    ];
    assert(_page.length == _bottomNavBarItem.length);

    final bottomNavBar = BottomNavigationBar(
      backgroundColor: Colors.green,
      items: _bottomNavBarItem,
      currentIndex: _currentINdex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentINdex = index;
        });
      },
    );
    return Scaffold(
      body: _page[_currentINdex],
      bottomNavigationBar: bottomNavBar,
    );
  }
}
