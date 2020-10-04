import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ibuy_mac_1/models/custom_user.dart';
import 'package:ibuy_mac_1/home/home.dart';
import 'package:ibuy_mac_1/screens/authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final theUser = Provider.of<CustomUser>(context);

    if(theUser == null) {
      return Authenticate();
      } else {
      return Home();
    }
  }
}