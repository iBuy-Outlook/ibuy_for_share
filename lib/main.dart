import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ibuy_mac_1/views/active_plan_dashboard.dart';
import 'package:ibuy_mac_1/views/onboarding_pages.dart';
import 'package:ibuy_mac_1/widgets/program_list.dart';
import 'views/home.dart';
import 'package:ibuy_mac_1/views/first_view.dart';
import 'package:ibuy_mac_1/views/sign_up_view.dart';
import 'package:ibuy_mac_1/widgets/provider_widget.dart';
import 'package:ibuy_mac_1/services/auth_service.dart';
import 'package:ibuy_mac_1/profiles/user_profile_view.dart';
import 'package:camera/camera.dart';
import 'package:ibuy_mac_1/views/get_plans.dart';
import 'package:ibuy_mac_1/profiles/receipts_view.dart';
import 'package:ibuy_mac_1/profiles/admin_profile_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibuy_mac_1/fixed_functionalities.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
// Obtain a list of the available cameras on the device.
// Get a specific camera from the list of available cameras.
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomProvider(
      auth: AuthService(),
      db: FirebaseFirestore.instance,
      child: ScreenUtilInit(
        designSize: Size(392.7272727
            , 807.2727273),
        allowFontScaling: false,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "iBuy App",
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            buttonTheme: ButtonThemeData(
              buttonColor: starBase,
              shape: RoundedRectangleBorder(),
              textTheme: ButtonTextTheme.primary,
              splashColor: splashBase,
          ),
          ),
          home: HomeController(),
          routes: <String, WidgetBuilder>{
            '/home': (BuildContext context) => HomeController(),
            '/signUp': (BuildContext context) => SignUpView(authFormType: AuthFormType.signUp),
            '/signIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.signIn),
            '/anonymousSignIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.anonymous),
            '/convertUser': (BuildContext context) => SignUpView(authFormType: AuthFormType.convert),
//            '/programList': (BuildContext context) => ProgramList(),
            '/profileView': (BuildContext context) => UserProfileView(),
//            '/getPlans': (BuildContext context) => GetPlans(),
//            '/getDash': (BuildContext context) => ActivePlanDashboard(),
            '/firstView': (BuildContext context) => FirstView(),
            '/receipts': (BuildContext context) => ReceiptsView(),
            '/adminProfile': (BuildContext context) => AdminProfileView(),
          },
        ),
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = CustomProvider.of(context).auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
//          return signedIn ? Home() : FirstView();
          return signedIn ? Home(fabOn: false) : OnboardingPages();
        //TODO: use if HomeView() is required in place of Home()
        }
        return CircularProgressIndicator();
      },
    );
  }
}

//TODO:- This is list of cool packages
//Local Auth for providing phone level authentication line finger printing, face recognition etc.
//Tutorial coach maker - for creating app tutorials
//Shimmer - to add shimmer effect in the App
//device info AND package info - to get user device information
//permission handler 5.0.1
//APIs - http or devo
//flutter slidable
//URL Launcher to launch web from the app
//Share - to share content through messages/apps/emails etc.
// Camera awesome
// different fonts flutter_screenutil 4.0.2+3
// https://www.canva.com/learn/100-color-combinations/ / 70, 74, 78, 81,86,95, 56,68,09, 21, 2, 
