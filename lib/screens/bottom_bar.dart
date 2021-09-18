import 'dart:async';

import 'package:online_store/constants/icons.dart';

import './search.dart';
import './user_info.dart';
import 'package:flutter/material.dart';

import 'cart.dart';
import 'feeds.dart';
import 'home.dart';

class BottomBarScreen extends StatefulWidget {
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  final List<Map<String, dynamic>>? _pages = [
    {
      'page': Home(),
    },
    {
      'page': Feeds(),
    },
    {
      'page': Search(),
    },
    {
      'page': Cart(),
    },
    {
      'page': UserInfo(),
    },
  ];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages![_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomAppBar(
        elevation: 5,
        notchMargin: 5,
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(width: .1)),
          ),
          child: BottomNavigationBar(
            onTap: _selectPage,
            currentIndex: _selectedPageIndex,
            backgroundColor: Theme.of(context).primaryColor,
            selectedItemColor: Colors.purple,
            unselectedItemColor: Theme.of(context).textSelectionColor,
            items: const [
              BottomNavigationBarItem(icon: Icon(KIcons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(KIcons.rss), label: 'Feeds'),
              BottomNavigationBarItem(icon: Icon(null), label: 'Search'),
              BottomNavigationBarItem(icon: Icon(KIcons.cart), label: 'Cart'),
              BottomNavigationBarItem(
                  icon: Icon(KIcons.user), label: 'Profile'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        elevation: 5,
        child: const Icon(Icons.search),
        onPressed: () {
          _selectPage(2);
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
