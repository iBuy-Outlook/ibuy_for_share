import 'package:flutter/material.dart';
import 'package:ibuy_mac_1/models/users_class.dart';
import 'package:provider/provider.dart';
import 'package:ibuy_mac_1/home/users_tile.dart';

class UsersList extends StatefulWidget {

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {

    final userDataSnap = Provider.of<List<UsersClass>>(context);
    userDataSnap.forEach((aUser) {
      print(aUser.name);
      print(aUser.sugar);
    });

    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: size.height,
          width: double.infinity,
          child: ListView.builder(
              itemCount: userDataSnap.length,
              itemBuilder: (context, index) {
                return UsersTile(aUser: userDataSnap[index]);
              }
          ),
        ),
      ],
    );
  }
}
