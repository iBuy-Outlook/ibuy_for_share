/*DEFINES THE STRUCTURE OF RETAILER PROGRAM*/
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class Program {

  final String retailerName;
  final String spendRange;
  final String regionalCode;
  final String minSpend;
  final String maxSpend;
  final String cashback;
  final String maxCustomers;
  final String startDate;
  final String endDate;
        String docID;

  Program({
    this.retailerName,
    this.spendRange,
    this.regionalCode,
    this.minSpend,
    this.maxSpend,
    this.cashback,
    this.maxCustomers,
    this.startDate,
    this.endDate,
});

  //formatting for upload to firebase when creating retailer Program
  Map<String, dynamic> toJson() => {
    'retailerName': retailerName,
    'spendRange': spendRange,
    'regionalCode': regionalCode,
    'minSpend': minSpend,
    'maxSpend': maxSpend,
    'cashback': cashback,
    'maxCustomers': maxCustomers,
    'startDate': startDate,
    'endDate': endDate,
  };

  // creating a Programs object from Firebase snapshot
  Program.fromSnapshot(DocumentSnapshot snapshot):
      retailerName = snapshot['retailerName'],
      spendRange = snapshot['spendRange'],
      regionalCode = snapshot['regionalCode'],
      minSpend = snapshot['minSpend'],
      maxSpend = snapshot['maxSpend'],
      cashback = snapshot['cashback'],
      maxCustomers = snapshot['maxCustomers'],
      startDate = snapshot['startDate'],
      endDate = snapshot['endDate'],
      docID = snapshot.id;
}