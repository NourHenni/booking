import 'package:booking_project/views/location_page.dart';
import 'package:booking_project/views/login_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';


import '../views/homePage.dart';

 

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 1;
  final _pageOptions = [
      LoginPage(),
      homePage(),
      LocationPage(),
      
  ];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        
        items: <Widget>[
       Icon(Icons.person_outline,size: 30),
        Icon(Icons.home,size: 30), 
        Icon(Icons.search,size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

