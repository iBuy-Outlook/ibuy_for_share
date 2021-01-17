import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ibuy_mac_1/models/user_plan.dart';
import 'package:ibuy_mac_1/widgets/progress_arc.dart';
import 'package:ibuy_mac_1/widgets/progress_donut.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialDisplayWidget extends StatefulWidget {
  final UserPlan userPlan;

  DialDisplayWidget({Key key, @required this.userPlan}) :super(key: key);

  @override
  _DialDisplayWidgetState createState() => _DialDisplayWidgetState();
}

class _DialDisplayWidgetState extends State<DialDisplayWidget>
    with SingleTickerProviderStateMixin{

  final db = FirebaseFirestore.instance;
  AnimationController progressController;
  Animation<double> animation;
  double pctSpendAchieved;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pctSpendAchieved = 100 * widget.userPlan.targetAchieved / widget.userPlan.budget;
    progressController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween<double>(begin: 0, end: pctSpendAchieved)
        .animate(CurvedAnimation(parent: progressController, curve: Curves.decelerate))
      ..addListener((){
      setState(() {
        //TODO - Add setState before app release
      });
    });
    progressController.forward();
  }

  @override
  void dispose() {
    progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(
          size: Size(200.w,200.w),
          foregroundPainter: ProgressArc(null, Colors.blueGrey[50], true),
        ),

        CustomPaint(
          size: Size(200.w,200.w),
          foregroundPainter: ProgressArc(animation.value, Colors.amber, false),
        ),

        // Center(
        //   child: Text('${animation.value.toInt()}%',
        //     style: TextStyle(
        //       fontSize: 16,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
        // Center(child: Text("About")),
      ],
    );
  }
}
