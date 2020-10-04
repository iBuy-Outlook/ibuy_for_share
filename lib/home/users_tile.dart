import 'package:flutter/material.dart';
import 'package:ibuy_mac_1/models/users_class.dart';

class UsersTile extends StatelessWidget {

  final UsersClass aUser;
  UsersTile({ this.aUser });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20,6,20,0),
        child: ListTile(
            leading: CircleAvatar(backgroundColor: Colors.green[300] , radius: 25,
            ),
            title: Text(aUser.name),
            subtitle: Text('Takes ${aUser.sugar} sugars')
        ),
      ),
    );
  }
}