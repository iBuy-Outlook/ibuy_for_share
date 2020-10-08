import 'package:flutter/material.dart';
import 'package:ibuy_mac_1/screens/app_body/view_profile.dart';
import 'package:ibuy_mac_1/shared/constants.dart';
import 'package:ibuy_mac_1/shared/loading.dart';

class BuildPlan extends StatefulWidget {
  @override
  _BuildPlanState createState() => _BuildPlanState();
}

class _BuildPlanState extends State<BuildPlan> {

  final _formKey = GlobalKey<FormState>();
  String postalCode = '';
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Build Your Plan'),
      ),
      body: Container(
        height: size.height,
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(10,10,10,10),
        margin:  EdgeInsets.fromLTRB(10,10,10,10),
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: size.height*0.02),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Find cashback in your area',
                  style: TextStyle(fontSize: 20),),
              ),
              SizedBox(height: size.height*0.02),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Postal Code'),
                validator: (val) => val.isEmpty ? 'Please enter a valid postal code' : null,
                onChanged: (val) => setState(() => postalCode = val),
              ),
              SizedBox(height: size.height*0.02),
              SizedBox(
                height: size.height*0.06,
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.amber,
                  child: Text(
                    'Go',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  onPressed: () {
                    if(_formKey.currentState.validate()){
                        setState(() {
                          loading = false;
                          error = 'Invalid postal code. Please try again.';
                          }
                        );
                      } else {
                      return ViewProfile();
                    }
                    }
                ),
              ),
              SizedBox(height: size.height*0.02),
              Divider(
                height: 5,
                thickness: 1,
                endIndent: 10,
                indent: 10,
              ),




    ],
        ),
      ),
    ),
    );
  }
}