/*THIS IS BODY OF THE NAVIGATION_VIEW PAGE...*/
import 'package:flutter/material.dart';
import 'package:ibuy_mac_1/services/database.dart';
import 'package:provider/provider.dart';
import 'package:ibuy_mac_1/widgets/program_list.dart';
import 'package:ibuy_mac_1/models/program.dart';
import 'package:ibuy_mac_1/widgets/divider_with_text_widget.dart';
import 'package:ibuy_mac_1/models/user_plan.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibuy_mac_1/models/user_profile.dart';
import 'package:ibuy_mac_1/widgets/provider_widget.dart';
import 'package:ibuy_mac_1/fixed_functionalities.dart';

class GetPlans extends StatelessWidget {
  final UserPlan userPlan;
  final UserProfile userProfile;

  GetPlans({Key key, @required this.userPlan, @required this.userProfile}) : super(key: key);
  final TextEditingController _postalCodeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Plan"),
      ),
      body: Container(
        color: Colors.white,
        child: StreamProvider<List<Program>>.value(
          value: DatabaseService().programSnapshots,
          child: Column(
            children: [
              _getZip(context, _postalCodeController),
              SizedBox(height: 10.h),
              DividerWithText(dividerText: 'Select Your Cashback Plan'),
              SizedBox(height: 10.h),
              Expanded(child: ProgramList(userPlan: userPlan, userProfile: userProfile)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getZip(context, _postalCodeController) {
    if(userProfile.postalCode != 'na') {
      return Container();
    } else {
      return Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(28,32,16,4),
              child: Align(
                child: Text('Enter your Postal Code to see nearby stores that are offering cashback',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.ssp,
                  ),
                ),
                alignment: Alignment.centerLeft,
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: const EdgeInsets.fromLTRB(16,4,16,16),
              child: Form(
                key: _formKey,
                child: TextFormField(
//                    controller: _postalCodeController,
                    decoration: textInputDecoration.copyWith(hintText: 'Postal Code'),
                    validator: (String value) {

                      if(value.trim().isEmpty) {
                        return 'Please enter a Postal Code';
                      }
                      if(RegExp(r'^[ABCEGHJ-NPRSTVXYabceghj-nprstvxy]\d[ABCEGHJ-NPRSTV-Zabceghj-nprstv-z][ -]?\d[ABCEGHJ-NPRSTV-Zabceghj-nprstv-z]\d$').hasMatch(value.trim()) == false) {
                        return 'Please enter a valid Postal Code';
                      }

                      return null;
                    },
                    onSaved: (String value) {
                      _postalCodeController = value.trim().replaceAll(RegExp(r'[ -]'), '').toUpperCase();
                    }
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
                onPressed: () async {
                  if(!_formKey.currentState.validate()) {
                    print('THIS IS THE POSTAL CODE VALUE $_postalCodeController');
                    return;
                } else {
                    _formKey.currentState.save();
                    print('THIS IS THE POSTAL CODE VALUE $_postalCodeController');
                    userProfile.postalCode = _postalCodeController;
                    //TODO: find a way to update userProfile.postalCode
                    await updateProfile(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          GetPlans(
                            userPlan: userPlan, userProfile: userProfile,)),
                    );
                  }

                },
              ),
            ),
          ],
        ),


      );
    }
  }

  final textInputDecoration = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    contentPadding: EdgeInsets.all(8.0),
    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: backLight, width: 1.0), borderRadius: BorderRadius.circular(3)),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: leadBase, width: 2.0), borderRadius: BorderRadius.circular(3),),
    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: errorBase, width: 2.0), borderRadius: BorderRadius.circular(3)),
    focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: errorBase, width: 2.0), borderRadius: BorderRadius.circular(3)),
  );

  Future updateProfile(context) async {
    final uid = await CustomProvider
        .of(context)
        .auth
        .getCurrentUID();
    final doc = CustomProvider
        .of(context)
        .db
        .collection('userData')
        .doc(uid);
    return await doc.setData(userProfile.toJson());
  }
}