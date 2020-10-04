import 'package:flutter/material.dart';
import 'package:ibuy_mac_1/screens/authenticate/sign_in.dart';
import 'package:ibuy_mac_1/screens/authenticate/sign_up.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = false;

  void toggleView () {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignUp(switchState: toggleView);
    } else {
      return SignIn(switchState: toggleView);
    }
  }
}
