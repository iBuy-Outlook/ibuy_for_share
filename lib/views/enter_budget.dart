/*THIS IS BODY OF THE NAVIGATION_VIEW PAGE...*/
import 'package:flutter/material.dart';
import 'package:ibuy_mac_1/services/database.dart';
import 'package:ibuy_mac_1/views/get_plans.dart';
import 'package:provider/provider.dart';
import 'package:ibuy_mac_1/models/program.dart';
import 'package:fontisto_flutter/fontisto_flutter.dart';
import 'package:ibuy_mac_1/models/user_plan.dart';
import 'package:ibuy_mac_1/models/user_profile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibuy_mac_1/fixed_functionalities.dart';
import 'dart:math' show Random;

class EnterBudget extends StatelessWidget {
  final UserPlan userPlan;
  final UserProfile userProfile;

  EnterBudget({Key key, @required this.userPlan, @required this.userProfile})
      : super(key: key);


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController _inputBudgetController = TextEditingController();
    return Container(
      child: StreamProvider<List<Program>>.value(value: DatabaseService().programSnapshots,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(28,32,16,4),
                  child: Align(
                    child: Text('Enter your Monthly Grocery Budget?',
                      style: TextStyle(
                        fontSize: 20.ssp,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16,4,16,16),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      // autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: budgetValidator,//                validator: BudgetValidator.validate,
                      controller: _inputBudgetController,
                      decoration: textInputDecoration.copyWith(
                        hintText: 'Average Spend',
                        prefixIcon: Icon(Istos.currency_dollar, size: 22.r, color: secondBase,),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0.07.sh,
                  width: 0.4.sw,
                  child: RaisedButton(
                    child: Text(
                      'Continue',
                      style: TextStyle(fontSize: 18.ssp),
                    ),
                    onPressed: () {
                          if (_formKey.currentState.validate()) {
                            userPlan.budget = double.parse(_inputBudgetController.text);
                            userPlan.targetAchieved = double.parse(_inputBudgetController.text)*(0.5+0.5*Random().nextDouble());
                            Navigator.push(context, MaterialPageRoute(builder: (context) => GetPlans(userPlan: userPlan, userProfile: userProfile)),);
                          }
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

  final textInputDecoration = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    contentPadding: EdgeInsets.all(8.0),
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: backLight, width: 1.0), borderRadius: BorderRadius.circular(3)),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: leadBase, width: 2.0), borderRadius: BorderRadius.circular(3),),
    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: errorBase, width: 2.0), borderRadius: BorderRadius.circular(3)),
    focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: errorBase, width: 2.0), borderRadius: BorderRadius.circular(3)),
    errorStyle: TextStyle(
      color: errorBase,
      backgroundColor: starLight,
      fontSize: 16.ssp,
    )
    ,
  );
  }