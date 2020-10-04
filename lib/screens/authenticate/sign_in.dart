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
                        TextFormField(
                          obscureText: true,
                          decoration: textInputDecoration.copyWith(hintText: 'Password'),
                          validator: (val) => val.length < 6 ? 'Please enter a valid password' : null,
                          onChanged: (val) => setState(() => password = val),
                        ),
                        SizedBox(height: size.height*0.02),
                        SizedBox(
                          height: size.height*0.06,
                          width: double.infinity,
                          child: RaisedButton(
                              color: Colors.amber,
                              child: Text(
                                'Sign In',
                                style: TextStyle(color: Colors.black, fontSize: 16),
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

                  SizedBox(height: size.height*0.01),
                  Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0),),
                  Row(
                    children: [
                      FlatButton(
                        child: Text('Forgot your password?',
                          style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold)
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: size.height*0.1),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.black54,
                          thickness: 1,
                          indent: 50,
                          endIndent: 20,
                          height: size.height*0.03,
                        ),
                      ),
                      Text('OR', style: TextStyle(color: Colors.black,),),
                      Expanded(
                        child: Divider(
                          color: Colors.black54,
                          thickness: 1,
                          indent: 20,
                          endIndent: 50,
                          height: size.height*0.03,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height*0.01),
                  SizedBox(
                    height: size.height*0.06,
                    width: double.infinity,
                    child: RaisedButton(
                      elevation: 0.5,
                      color: Colors.blueGrey[100],
                      child: Text(
                        'Create a new account',
                        style: TextStyle(
                          fontSize: 16.0,
                          //fontWeight: FontWeight.bold,
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