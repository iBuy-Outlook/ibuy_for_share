import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibuy_mac_1/camera/image_capture.dart';
import 'package:ibuy_mac_1/profiles/menu_pages.dart';
import 'package:ibuy_mac_1/views/home_view.dart';
import 'package:ibuy_mac_1/models/user_plan.dart';
import 'package:ibuy_mac_1/widgets/provider_widget.dart';

class Home extends StatefulWidget {
  final bool fabOn;

  Home({Key key, @required this.fabOn}) :super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grocery Budget"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[Colors.blueGrey, Colors.white])
              ),
              child: Container(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Row(
                        children: [
                          CircleAvatar(
                            child: Icon(Icons.person, size: 40),
                            radius: 40,
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.amber,
                          ),
                          FutureBuilder(
                              future: CustomProvider
                                  .of(context)
                                  .auth
                                  .getCurrentUser(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return displayUserInformation(
                                      context, snapshot);
                                } else {
                                  return CircularProgressIndicator();
                                }
                              }),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  )
              ),
            ),
            CustomMenuTile(Icons.person, "Profile", 0),
            CustomMenuTile(Icons.attach_money, "Order Cashback", 1),
            CustomMenuTile(Icons.auto_awesome, "Current Plan", 2),
            CustomMenuTile(Icons.history, "Plan History", 3),
            CustomMenuTile(Icons.notifications_none, "Notifications", 4),
            CustomMenuTile(Icons.help, "Help", 5),
            CustomMenuTile(Icons.settings, "Settings", 6),

          ],
        ),
      ),
      body: HomeView(),
      floatingActionButton: _getFAB(),
    );
  }

  Widget _getFAB() {
    if (!widget.fabOn) {
      return Container();
    } else {
      return FloatingActionButton.extended(
        label: Text('Scan Receipts'),
        backgroundColor: Colors.pink,
        icon: Icon(Icons.receipt),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ImageCapture())
          );
        },
      );
    }
  }

  Widget displayUserInformation(context, snapshot) {
      final user = snapshot.data;
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),

            child: Text("${user.email ?? 'Anonymous'}",
                style: TextStyle(fontSize: 16)),
          ),
        ],
      );
    }
}

class CustomMenuTile extends StatelessWidget {
  final IconData _icon;
  final String _itemText;
  final int _index;

  CustomMenuTile(this._icon, this._itemText, this._index);

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16,0,8,0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MenuPages(menuIndex: _index, pageTitle: _itemText))
          );
        },
        splashColor: Colors.amberAccent,
        child: Container(
          height: _height*0.07,
          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(_icon, size: 25,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _itemText,
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

