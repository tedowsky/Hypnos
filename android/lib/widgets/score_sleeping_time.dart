import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages


class ScoreSleepingTime extends CustomPainter {
  const ScoreSleepingTime(
      {required this.backColor,
      required this.frontColor,
      required this.strokeWidth,
      required this.value});
  final Color backColor, frontColor;
  final double strokeWidth, value;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final paint1 = Paint()
      ..strokeWidth = strokeWidth
      ..color = backColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final paint2 = Paint()
      ..strokeWidth = strokeWidth
      ..color = frontColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final r =
        Rect.fromCenter(center: Offset(w / 2, h / 2), width: w, height: h);
    ///canvas.drawCircle(c, r, paint1)  ; 
    //canvas.drawCircle(c, radius, paint) ;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}