import 'package:flutter/material.dart';

import 'expenses_page_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetList = <Widget>[
    ExpensesPageWidget(),
    Text(
      'Index 1: Заработок',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.circle,
              color: Color.fromARGB(255, 232, 232, 232),
            ),
            label: 'Расходы',
            activeIcon: Icon(
              Icons.circle,
              color: Color.fromARGB(255, 93, 176, 117),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.circle,
              color: Color.fromARGB(255, 232, 232, 232),
            ),
            label: 'Доходы',
            activeIcon: Icon(
              Icons.circle,
              color: Color.fromARGB(255, 93, 176, 117),
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 93, 176, 117),
        onTap: _onItemTapped,
      ),
      body: _widgetList.elementAt(_selectedIndex),
    );
  }
}
