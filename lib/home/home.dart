import 'package:flutter/material.dart';
import 'package:ibuy_mac_1/screens/app_body/create_plan.dart';
import 'package:ibuy_mac_1/screens/app_body/order_cashback.dart';
import 'package:ibuy_mac_1/screens/app_body/view_profile.dart';
import 'package:ibuy_mac_1/services/auth.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  int _currentIndex = 0;
  List<Widget> _bottomNavigationPages1 = [
    CreatePlan(),
    OrderCashback(),
    ViewProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Cashback Offers'),
          backgroundColor: Colors.amber[600],
        ),
        body: _bottomNavigationPages1[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: onTapFunction,
          items: [
            BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Create Plan',),
            BottomNavigationBarItem(
                icon: Icon(Icons.request_page),
                label: 'Order Your Check',),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',),
          ],
        ),
      );
  }

  void onTapFunction(int i) {
    setState(() {
      _currentIndex = i;
    });
  }
}






