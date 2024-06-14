import 'package:booking_project/views/menu_page.dart';
import 'package:booking_project/views/homeHote.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../views/client.dart';
import '../views/clientSuite.dart';
import '../views/userProfile.dart';
import '../views/usercompte.dart';
import '../views/mypage.dart';
import '../views/homePage.dart';


class clientBar extends StatefulWidget{

   _clientBar createState() => _clientBar();

}

class _clientBar extends State<clientBar> {

  int _selectedIndex = 1;
  final _pageOptions = [
      
      menuPage(),
      clientSuite(),
      userProfile()
    
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        
        items: <Widget>[
        Icon(Icons.search,size: 30), 
        Icon(Icons.home,size: 30), 
        Icon(Icons.person_outline,size: 30),
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