import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ibuy_mac_1/screens/app_body/view_profile.dart';
import 'package:ibuy_mac_1/screens/authenticate/reset_password.dart';
import 'package:ibuy_mac_1/screens/authenticate/sign_in.dart';
import 'package:ibuy_mac_1/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:ibuy_mac_1/models/custom_user.dart';
import 'package:ibuy_mac_1/services/auth.dart';
import 'package:ibuy_mac_1/screens/wrapper.dart';
import 'screens/app_body/build_plan.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser>.value(
      value: AuthService().userLoginStream,
      child: MaterialApp(

        //ROUTING PROPERTIES
        //home: Wrapper(),
        initialRoute: '/wrapper',
//        initialRoute: '/build_plan',
        routes: {
          '/' : (context) => Loading(),
          '/wrapper' : (context) => Wrapper(),
          '/viewProfile' : (context) => ViewProfile(),
          '/build_plan' : (context) => BuildPlan(),
          '/ResetPassword' : (context) => ResetPassword(),
          '/SignIn' : (context) => SignIn(),
        },

      ),
    );
  }
}