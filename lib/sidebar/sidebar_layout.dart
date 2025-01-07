import 'package:flutter/material.dart';
import 'package:medex/screens/home_screen.dart';
import 'package:medex/sidebar/sidebar.dart';

class SidebarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: <Widget>[
          HomePage(),
          Sidebar(),
        ],
      ),
    );
  }
}
