import 'package:flutter/material.dart';
import 'package:ibuy_mac_1/services/auth.dart';
import 'package:ibuy_mac_1/shared/constants.dart';
import 'package:ibuy_mac_1/shared/loading.dart';

class ResetPassword extends StatefulWidget {

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = 'jalksjdl';
  bool loading = false;

  // text field state
  String email = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading ? Loading() : SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                SizedBox(height: size.height*0.05),

                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) => val.isEmpty ? 'Please enter a valid email' : null,
                        onChanged: (val) => setState(() => email = val),
                      ),
                      SizedBox(height: size.height*0.01),
                      SizedBox(
                        height: size.height*0.06,
                        width: double.infinity,
                        child: RaisedButton(
                            color: Colors.amber,
                            child: Text(
                              'Reset Password',
                              style: TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            onPressed: () async {
                              if(_formKey.currentState.validate()){
                                //setState(() => loading = true);
                                dynamic result = await _auth.sendPasswordResetEmail(email);
                                print(result);
                                if(result != null) {
                                    setState(() {error = 'No such user exists. Please try again';});
                                } else {
                                    Navigator.pushNamed(context, '/SignIn');
                                  }
                                }
                            }
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: size.height*0.01),
                Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0),),
                SizedBox(height: size.height*0.1),
              ],

            ),
          ),
        ),
      ),
    );
  }
}