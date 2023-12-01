// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_print, library_private_types_in_public_api

import 'package:app_commerce/const/AppColors.dart';
import 'package:app_commerce/ui/bottom_nav_pages/cart.dart';
import 'package:app_commerce/ui/bottom_nav_pages/home.dart';
import 'package:app_commerce/ui/bottom_nav_pages/profile.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class BottomNavController extends StatefulWidget {
  @override
  _BottomNavControllerState createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  final _pages = [
    Home(),
    
    Cart(),
    Profile(),
  ];
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "AgriAdvisorPro",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        selectedItemColor: AppColors.deep_orange,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        selectedLabelStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          BottomNavigationBarItem(
            icon: Icon (EvaIcons.home),
            label: ("Home"),
          ),
          BottomNavigationBarItem(
              icon: Icon(EvaIcons.heart),
              label: ("Favourite")),
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.shoppingCart),
            label: ("Cart"),
          ),
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.person),
            label: ("Person"),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            print(_currentIndex);
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}
