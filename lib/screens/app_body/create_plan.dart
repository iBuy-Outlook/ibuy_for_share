import 'package:flutter/material.dart';
import 'package:ibuy_mac_1/models/cb_plan_ranges.dart';

class CreatePlan extends StatefulWidget {
  @override
  _CreatePlanState createState() => _CreatePlanState();
}

class _CreatePlanState extends State<CreatePlan> {

  final List<CBPlanRanges> _planRange = [
    CBPlanRanges(600, 800, 5, 6),
    CBPlanRanges(400, 600, 4, 5),
    CBPlanRanges(200, 400, 3, 4),
    CBPlanRanges(100, 200, 2, 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: _planRange.length,
        itemBuilder: (BuildContext _context, int index) {
          return buildPlannerCard(_context, index);
        },
      ),
    );
  }

  Widget buildPlannerCard(BuildContext _context, int index) {
    //Size size = MediaQueryData().size;
    final plan = _planRange[index];
    return Container(
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.fromLTRB(4, 8, 4, 4),
        color: Colors.grey[(_planRange.length - index)*100],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
//              Text(index.toString()),
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 2),
                child: Row(
                  children: [
                    Column(children: [Text('Monthly Spend', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),],),
                    Spacer(),
                    Column(children: [Text('Cashback', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),],),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 8),
                child: Row(
                  children: [
                    Column(children: [Text("\$${plan.minSpend.toString()} - \$${plan.maxSpend.toString()}", style: TextStyle(fontSize: 16, color: Colors.black54),),],),
                    Spacer(),
                    Column(children: [Text("${plan.minCB.toString()}% - ${plan.maxCB.toString()}%", style: TextStyle(fontSize: 16, color: Colors.black54),),],),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
