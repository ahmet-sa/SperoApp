import 'package:flutter/material.dart';
import 'package:spero_app_/pages/navigation_bar_printer_control_page.dart';

import 'navigaion_bar_queue_control_page.dart';

class HomePage extends StatefulWidget {
  final String Ip;
  final String Api;

  


  

  const HomePage({super.key, required this.Ip, required this.Api});@override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;
  @override




  @override
  Widget build(BuildContext context) {
  final List<Widget> _pages = [
    
    NavigatorBar3DControlPage(),
    NavigatorBarPrinterControlPage(Ip: widget.Ip, Api: widget.Ip),
    NavigatorBar3DControlPage(),
  ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Spero 3D'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Queue',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '3D Control',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
