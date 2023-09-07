import 'package:flutter/material.dart';
import 'package:stock/Screens/add.dart';

import 'package:stock/Screens/Home.dart';
import 'package:stock/Screens/Item.dart';
import 'package:stock/Screens/setting.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:stock/view/profit/profit.dart';

class Bottom extends StatefulWidget {
  const Bottom({super.key});

  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int _currentIndex = 0;

  final List<Widget> bottomBarPages = [
    const Home(),
    Item(),
    const Add(),
    const Profit(),
    const Setting(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 222, 228, 255),
        body: bottomBarPages[_currentIndex],
        bottomNavigationBar: FloatingNavbar(
          onTap: (int val) => setState(() => _currentIndex = val),
          currentIndex: _currentIndex,
          items: [
            FloatingNavbarItem(icon: Icons.home, title: 'Home'),
            FloatingNavbarItem(icon: Icons.inventory, title: 'Item'),
            FloatingNavbarItem(
              icon: Icons.add,
              title: 'Add',
            ),
            FloatingNavbarItem(
                icon: Icons.trending_up_outlined, title: 'Profit'),
            FloatingNavbarItem(icon: Icons.settings, title: 'Setting'),
          ],
        ),
      ),
    );
  }
}
