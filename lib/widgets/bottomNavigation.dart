import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:elaptop/screens/cartscreen.dart';
import 'package:elaptop/screens/listproduct.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/home.dart';
// import 'package:project/screens/infor.dart';

//screens
// . . .

class BottomNavigationBarC extends StatefulWidget {
  static const routeName = "bottom-navigation";
  @override
  _BottomNavigationBarCState createState() => _BottomNavigationBarCState();
}

class _BottomNavigationBarCState extends State<BottomNavigationBarC> {
  static const IconData shopping_bag_outlined = IconData(0xf37d, fontFamily: 'MaterialIcons');
  late int index;
  @override
  void initState() {
    super.initState();
      index = 0;
  }

  bodyWidget(int pos) {
    switch (pos) {
      case 0:
        return Home();
      case 1:
        return ListProduct();
      case 2:
        return null;
      case 3:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(
        Icons.home,
        size: 30,
      ),
      const Icon(Icons.dashboard, size: 30),
      const Icon(shopping_bag_outlined  , size: 30),
      const Icon(Icons.account_circle_rounded, size: 30),
    ];
    return Scaffold(
      extendBody: true,
      // appBar: AppBar(
      //   elevation: 0,
      // ),
      // body: Center(
      //   child: Text(
      //     '${index+1}',
      //     style: const TextStyle(
      //       color: Colors.blueAccent,
      //       fontSize: 120,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      bottomNavigationBar: CurvedNavigationBar(
          color: Colors.blueAccent,
          backgroundColor: Colors.transparent,
          height: 60,
          index: index,
          items: items,
          onTap: (index) => {setState(() => this.index = index)}),
      body: bodyWidget(index),
    );
  }
}
