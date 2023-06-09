import 'package:flutter/material.dart';

class MeasurementPainter extends CustomPainter {
  final Offset textPosition;
  final Offset bodyPartPosition;
  final Color color = Color(0xFFEE8B60);
  final double strokeWidth;

  MeasurementPainter(
      {required this.textPosition,
      required this.bodyPartPosition,
      this.strokeWidth = 2});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = this.color
      ..strokeWidth = this.strokeWidth;

    canvas.drawLine(this.textPosition, this.bodyPartPosition, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
