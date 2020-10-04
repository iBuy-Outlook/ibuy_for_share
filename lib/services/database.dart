import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ibuy_mac_1/models/users_class.dart';

class DatabaseService{

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('appUsers');

  Future updateUserData(
      String name,
      String postalCode,
      String sugar,
      int tier,
      bool isActive,
      String planID,
      ) async {
    return await userCollection.doc(uid).set({
      'name' : name,
      'postalCode' : postalCode,
      'sugar' : sugar,
      'tier' : tier,
      'isActive' : isActive,
      'planID' : planID,
    });
  }

  //get 'list of used info' from the snapshot
  List<UsersClass> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UsersClass(
        name: doc.data()['name'] ?? '',
        postalCode: doc.data()['postalCode'] ?? '',
        sugar: doc.data()['sugars'] ?? '0',
        tier: doc.data()['tier'] ?? 100,
        isActive: doc.data()['isActive'] ?? true,
        planID: doc.data()['planID'] ?? '',

      );
    }).toList();
  }

  //get userCollection stream
  Stream<List<UsersClass>> get userDataSnap {
    return userCollection.snapshots()
        .map(_userListFromSnapshot);
  }
}