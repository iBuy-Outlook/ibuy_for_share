import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ibuy_mac_1/models/user_plan.dart';
import 'package:ibuy_mac_1/views/dial_display_widget.dart';
import 'package:ibuy_mac_1/views/home.dart';
import 'package:ibuy_mac_1/widgets/provider_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibuy_mac_1/fixed_functionalities.dart';

class ActivePlanDashboard extends StatelessWidget {
  final UserPlan userPlan;

  final db = FirebaseFirestore.instance;
  ActivePlanDashboard({Key key, @required this.userPlan}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final daysLeft = userPlan.endDate.toDate().difference(userPlan.startDate.toDate()).inDays;

    final _smallFont = 18.ssp;
    final _mediumFont = 20.ssp;
    final _bigFont = 24.ssp;

    return Container(
      width: width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              children: [
                Text('You are almost there !!',
                  style: TextStyle(fontSize: _mediumFont, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 0.03.sw),
                // Text('Retailer - ${userPlan.retailerName} '),
                // Text('Cashback - ${userPlan.cashback}% Cashback '),
                // Text('Spend - \$${userPlan.budget} '),
                Container(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.0), height: 0.6.sw, width: 0.6.sw,
                        child: DialDisplayWidget(userPlan: userPlan),
                      ),
                      Positioned(
                        top: 0.15.sw,
                        child: Container(width: 0.6.sw,
                          child: Column(
                            children: [
                              Text('Spent',
                                style: TextStyle(
//                                    fontWeight: FontWeight.bold,
                                    fontSize: _smallFont,
                                    color: leadBase,
                                ),
                              ),
                              Text('\$${userPlan.targetAchieved.toInt()}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: _mediumFont,
//                                  color: leadBase
                                ),
                              ),
                              SizedBox(height: 0.03.sw),
                              Text('Target \$${userPlan.budget.toInt()}',
                                style: TextStyle(
//                                  fontWeight: FontWeight.bold,
                                  fontSize: _smallFont,
                                  color: secondBase,
                                ),

                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0.4.sw,
                        left: -0.15.sw,
                        child: Container(width: 0.9.sw, height: 0.17.sw,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 0.4.sw,
                                decoration: BoxDecoration(
//                                  border: Border.all(color: backLight),
                                  //borderRadius: BorderRadius.circular(3.r),
                                  color: backDark,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text('Time left',
                                        style: TextStyle(
//                                    fontWeight: FontWeight.bold,
                                          fontSize: _smallFont,
                                          color: leadBase
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 0.02.sw),
                                    Text('$daysLeft days',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: _mediumFont,
//                                    color: secondBase,
                                      ),

                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 0.4.sw,
                                decoration: BoxDecoration(
//                                  border: Border.all(color: backLight),
                                  borderRadius: BorderRadius.circular(3.r),
                                  color: backDark,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Pending spend',
                                      style: TextStyle(
//                                    fontWeight: FontWeight.bold,
                                          fontSize: _smallFont,
                                          color: leadBase,
                                      ),
                                    ),
                                    SizedBox(height: 0.02.sw),
                                    Text('\$${(userPlan.budget.toInt() - userPlan.targetAchieved.toInt())}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: _mediumFont,
//                                    color: secondBase,
                                      ),

                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

                Text('Continue shopping at your selected ${userPlan.retailerName} stores'),
                SizedBox(height: 0.1.sh),

//TODO: Remove this button in the final version. User can change plan before accepting.
//TODO: An ongoing plan can be changed from 'Current Plan' under main Menu
                Text("Don't like this plan?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: splashBase,
                ),),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 0.07.sh,
                  width: 0.65.sw,
                  child: RaisedButton(
                    color: backLight,
                    textColor: Colors.black87,
                    child: Text('Cancel and Create New',
                      style: TextStyle(
                        fontSize: _mediumFont,
                      ),
                    ),
                    onPressed: () async {
                      userPlan.status = "canceled";
                      final uid = await CustomProvider.of(context).auth.getCurrentUID();
                      await db.collection("userData").doc(uid).collection("userPlansCanceled").doc().set(userPlan.toJson());
                      await db.collection("userData").doc(uid).collection("userPlansActive").doc('active').delete();
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home(fabOn: false))
                      );
                    },
                  ),
                ),
                SizedBox(height: 30.h),
                Text("OR",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: splashBase,
                  ),),
              ],
            ),
          ),
        ),
    );
  }
}
