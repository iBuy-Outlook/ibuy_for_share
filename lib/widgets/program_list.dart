/*THIS LIST VIEW DISPLAY FOR THE HOME_VIEW PAGE*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ibuy_mac_1/views/accept_plan.dart';
import 'package:provider/provider.dart';
import 'package:ibuy_mac_1/models/program.dart';
import 'package:ibuy_mac_1/models/user_profile.dart';
import 'package:ibuy_mac_1/models/user_plan.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibuy_mac_1/fixed_functionalities.dart';

class ProgramList extends StatelessWidget {
  final UserPlan userPlan;
  final UserProfile userProfile;

  ProgramList({Key key, @required this.userPlan, @required this.userProfile}) : super(key: key);

  /*define local variables*/
  List<Program> _programsNew;
  String _postalCode='na';
  int _listLength = 0;

  @override
  Widget build(BuildContext context) {

    final List<Program> programsAll = Provider.of<List<Program>>(context);
    _postalCode = userProfile.postalCode;

   if (programsAll!=null && _postalCode !='na') {
      _programsNew = programsAll
          .where((i) => (
          !i.retailerName.contains('Metro') &&
          i.regionalCode.contains(_postalCode.substring(0,3))
      )).toList()
      ;
      print('      THESE ARE THE FIRST # LETTERS      ${_postalCode.substring(0,3)}');

    } else {
      _programsNew = [Program(retailerName: 'Please provide Postal Code', spendRange: 'na', regionalCode: 'na', minSpend: 'na', maxCustomers: 'na', cashback: '', maxSpend: 'na',startDate: null, endDate: null)];
    }

    _listLength = _programsNew.length;
    print('LIST LENGTH ------- $_listLength');

    return ListView.builder(
        itemCount: _listLength,
        itemBuilder: (context, index) {
          return programTile(context, _programsNew[index], userProfile);
        }
    );
  }

  programTile(BuildContext context, tileElements, userProfile) {
//    DateTime _startDate = DateTime.now();
//    Timestamp _startDaten = DateTime.now().toUtc().millisecondsSinceEpoch
//    DateTime _endDate = DateTime.now().add(Duration(days: 30));

    Timestamp _startDate = Timestamp.fromDate(DateTime.now());
    Timestamp _endDate = Timestamp.fromDate(DateTime.now().add(Duration(days: 30)));

    return Hero(
      //tag: "SelectedTrip-${userPlan.retailerName}",
      tag: _endDate,
      transitionOnUserGestures: true,
      child: Container(
        padding: EdgeInsets.only(top: 8),
        child: Card(
          color: secondLight,
          margin: EdgeInsets.fromLTRB(20,6,20,0),
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(height: 50.h),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            AutoSizeText(tileElements.retailerName,
                              maxLines: 2,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.ssp),
                            ),
                          ],),
                      ],
                    ),
                  ),
                  Column(
                      children: [
                        Row(
                            children: [
                              AutoSizeText(tileElements.cashback,
                                maxLines: 2,
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.ssp),
                              ),
                            ]
                        ),
                      ]
                  ),
                ],
              ),
            ),
            onTap: () {
              userPlan.retailerName = tileElements.retailerName;
              userPlan.cashback = double.parse(tileElements.cashback.substring(0, tileElements.cashback.length - 1));
              userPlan.startDate = _startDate;
              userPlan.endDate = _endDate;
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AcceptPlan(userPlan: userPlan)),
              );
            },
          ),
        ),
      ),
    );
  }
}