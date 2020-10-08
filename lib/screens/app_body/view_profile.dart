import 'package:flutter/material.dart';
import 'package:ibuy_mac_1/home/users_list.dart';
import 'package:ibuy_mac_1/models/users_class.dart';
import 'package:ibuy_mac_1/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:ibuy_mac_1/services/database.dart';
import 'package:ibuy_mac_1/services/auth.dart';

class ViewProfile extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamProvider<List<UsersClass>>.value(
      value: DatabaseService().userDataSnap,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
//                Container(
//                  child: UsersList(),
//                ),
                SizedBox(height: size.height*.1),
                Text('This is Profile View Page.', style: TextStyle(fontSize: 20, color: Colors.black54)),
                RaisedButton(
                  child: Text('Sign Out'),
                  onPressed: () {
                      return _auth.logOut();
                    }
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
