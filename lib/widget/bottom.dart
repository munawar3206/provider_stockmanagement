import 'package:flutter/material.dart';

import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:stock/helpers/app_colors.dart';
import 'package:stock/view/add/add.dart';
import 'package:stock/view/home/home.dart';
import 'package:stock/view/item/item.dart';
import 'package:stock/view/profit/profit.dart';
import 'package:stock/view/setting/setting.dart';

class Bottom extends StatefulWidget {
  const Bottom({super.key});

  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int _currentIndex = 0;

  final List<Widget> bottomBarPages = [
    const Home(),
    const Item(),
    AddForm(),
    const Profit(),
    const Setting(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor:AppColors.bg,
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
