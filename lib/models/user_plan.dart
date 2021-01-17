import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class UserPlan {
  String retailerName;
  Timestamp startDate;
  Timestamp endDate;
  double budget;
  double targetAchieved;
  double cashback;
  String status;
  String postalCode;
  String id;

  UserPlan(
      this.retailerName,
      this.startDate,
      this.endDate,
      this.budget,
      this.targetAchieved,
      this.cashback,
      this.status,
      this.postalCode,
      );

  //formatting for upload to firebase while creating a userPlan
  Map<String, dynamic> toJson() => {
    'retailerName': retailerName,
    'startDate': startDate,
    'endDate': endDate,
    'budget': budget,
    'targetAchieved': targetAchieved,
    'cashback': cashback,
    'status': status,
    'postalCode': postalCode,
  };

  //creating a userPlan object from a firebase snapshot
  UserPlan.fromSnapshot(DocumentSnapshot snapshot) :
        retailerName = snapshot['retailerName'],
        startDate = snapshot['startDate'],
        endDate = snapshot['endDate'],
        budget = snapshot['budget'],
        targetAchieved = snapshot['targetAchieved'],
        cashback = snapshot['cashback'],
        status = snapshot['status'],
        postalCode = snapshot['postalCode'],
        id = snapshot.id;
}