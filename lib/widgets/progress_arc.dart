import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as mathAdd;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressArc extends CustomPainter {
  double arc;
  Color progressColor;
  bool isBackground;

  ProgressArc(this.arc, this.progressColor, this.isBackground);

  @override
  void paint(Canvas canvas, Size size) {
    double stroke = 20.ssp;
    final height = size.height;
    final width = size.width;
    final rect = Rect.fromLTRB(0,0,height,width);
    final startAngle = -math.pi;
    final sweepAngle = arc != null ? arc*math.pi/100 : math.pi;

    final useCenter = false;

    final customPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;

    if(!isBackground) {
      customPaint.shader = LinearGradient(colors: [
        Colors.amber, Colors.green
      ]).createShader(rect);
    }
      canvas.drawArc(rect, startAngle, sweepAngle, false, customPaint);
    }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}