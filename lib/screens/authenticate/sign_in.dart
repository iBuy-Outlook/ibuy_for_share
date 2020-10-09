import 'package:flutter/material.dart';
import 'package:ibuy_mac_1/services/auth.dart';
import 'package:ibuy_mac_1/shared/constants.dart';
import 'package:ibuy_mac_1/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function switchState;
  SignIn({ this.switchState });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return loading ? Loading() : SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              height: _height,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: _height*0.03),
                  Image(
                    image: AssetImage('assets/ibuylogo_1.png'),
                    height: _height*0.15,
                  ), //Image
                  Text('Cashback on Groceries',
                    style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Colors.green[800],
                    ),
                  ), //Text
                  SizedBox(height: _height*0.05),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          style: TextStyle(fontSize: 18),
                          decoration: textInputDecoration.copyWith(hintText: 'Email'),
                          validator: (val) => val.isEmpty ? 'Please enter a valid email' : null,
                          onChanged: (val) => setState(() => email = val),
                        ),
                        SizedBox(height: _height*0.01),
                        TextFormField(
                          style: TextStyle(fontSize: 18),
                          obscureText: true,
                          decoration: textInputDecoration.copyWith(hintText: 'Password'),
                          validator: (val) => val.length < 6 ? 'Please enter a valid password' : null,
                          onChanged: (val) => setState(() => password = val),
                        ),
                        SizedBox(height: _height*0.02),
                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),),
                              color: Colors.amber,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(color: Colors.black, fontSize: 18),
                                ),
                              ),
                              onPressed: () async {
                                if(_formKey.currentState.validate()){
                                  setState(() => loading = true);
                                  dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                                  if(result == null) {
                                    setState(() {
                                      loading = false;
                                      error = 'Invalid account. Please try again.';
                                      }
                                    );
                                  }
                                }
                              }
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: _height*0.01),
                  Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0),),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FlatButton(
                      child: Text('',
                        style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold)
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/ResetPassword');
                        },
                    ),
                  ),
                  SizedBox(height: _height*0.05),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '    Don\'t have an account?',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[700],),
                    ),
                  ),
                  SizedBox(height: _height * 0.01),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),),
                      color: Colors.blueGrey[100],
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 18.0,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onPressed: () {
                        widget.switchState();
                      },
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