import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: size.height*0.05),
                Image(
                  image: AssetImage('assets/ibuylogo_1.png'),
                  height: size.height*0.15,
                ), //Image
                Text('Cashback on Groceries',
                  style: TextStyle(fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Colors.green[800],
                  ),
                ), //Text
                SizedBox(height: size.height*0.15),
                Center(
                  child: SpinKitCircle(
                    color: Colors.blueGrey[700],
                    size: 100.0,
                  ),
                ),
              ],
            ),
          ),
        ),
    ),
    );
  }
}