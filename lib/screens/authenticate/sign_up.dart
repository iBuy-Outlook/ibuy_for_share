import 'package:flutter/material.dart';
import 'package:ibuy_mac_1/services/auth.dart';
import 'package:ibuy_mac_1/shared/constants.dart';
import 'package:ibuy_mac_1/shared/loading.dart';

class SignUp extends StatefulWidget {

  final Function switchState;
  SignUp({ this.switchState });

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  //define text fields states/variables/properties
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
                    children: [
                      TextFormField(
                        decoration: textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) => val.isEmpty ? 'Please enter a valid email ID' : null,
                        onChanged: (val) => setState(() => email = val),
                      ),
                      SizedBox(height: size.height*0.01),
                      TextFormField(
                        obscureText: true,
                        decoration: textInputDecoration.copyWith(hintText: 'Password'),
                        validator: (val) => val.length < 6 ? 'Please select password with 6+ characters' : null,
                        onChanged: (val) => setState(() => password = val),
                      ),
                      SizedBox(height: size.height*0.02),
                      SizedBox(
                        height: size.height*0.06,
                        width: double.infinity,
                        child: RaisedButton(
                          color: Colors.amber,
                          child: Text(
                            'Create Account',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error = 'Please enter valid account details';
                                  }
                                );
                              }
                            }
                          }
                        ),
                      ), //Create Account
                    ],
                  ),
                ),

                SizedBox(height: size.height*0.01),
                Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0),),
                Row(
                  children: [
                    FlatButton(
                      child: Text('',
                          style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold)
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: size.height*0.11),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '  Already have an account?',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[700],),
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
                      'Log In',
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
