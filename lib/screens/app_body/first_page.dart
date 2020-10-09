import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  final primaryColor = Colors.amber;

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: _height,
          width: _width,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: _height * 0.05,
                  ),
                  Image(
                    image: AssetImage('assets/ibuylogo_1.png'),
                    height: _height * 0.15,
                  ), //Image
                  Text(
                    'Cashback on Groceries',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: Colors.green[800],
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.1,
                  ), //Image
                  Text(
                    'Get guaranteed cashback on every \$ you spend on Grocery',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.2,
                  ), //Image
                  Text(
                    'Start earning today!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: _height * 0.01),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      elevation: 0.5,
                      color: Colors.amber,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 20.0,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/SignUp');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
