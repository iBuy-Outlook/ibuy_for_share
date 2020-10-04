import 'package:firebase_auth/firebase_auth.dart';
import 'package:ibuy_mac_1/models/custom_user.dart';
import 'package:ibuy_mac_1/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create function to return FirebaseUser (User) in CustomUser format
  CustomUser _userFromFirebase(User rawUser) {
    return rawUser != null ? CustomUser(uid: rawUser.uid) : null;
  }

  //auth change user stream
  Stream<CustomUser> get userLoginStream {
    return _auth.authStateChanges().map(_userFromFirebase);
}

  //sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User appUser = result.user;
      return _userFromFirebase(appUser);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //sign-in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User appUser = result.user;
      return _userFromFirebase(appUser);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User appUser = result.user;

      //create new document with this user ID
      await DatabaseService(uid: appUser.uid).updateUserData('new member', 'L7G5X8', '0', 100, true, '9999');

      return _userFromFirebase(appUser);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future logOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}