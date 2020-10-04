import 'package:flutter/material.dart';
import 'package:ibuy_mac_1/services/auth.dart';

class Home2 extends StatelessWidget {

  final AuthService _auth = AuthService();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Cashback Offers'),
          backgroundColor: Colors.amber[600],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [

              Container(
                //height: size.height,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height*.1),
                    Text('This is Home Screen.', style: TextStyle(fontSize: 20, color: Colors.black54)),
                    SizedBox(height: size.height*.1),
                    RaisedButton(
                      color: Colors.amber,
                      child: Text(
                        'User Profile',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black54,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/viewProfile');
                      },
                    ), //Profile View
                    RaisedButton(
                      color: Colors.red,
                      child: Text(
                        'Sign Out',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        await _auth.logOut();
                      },
                    ), //Log out
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.money),
                label: 'Create Plan'),
            BottomNavigationBarItem(
                icon: Icon(Icons.request_page),
                label: 'Order Your Check'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile'),
          ],
        ),
      );
  }
}






