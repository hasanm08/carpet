import 'dart:math';

import 'package:flutter/material.dart';

class OctagonPainter extends CustomPainter {
  final Color borderColor;
  final double strokeWidth;
  final int sides;


  OctagonPainter({
    this.borderColor = Colors.indigo,
    this.strokeWidth = 1.0,
    required this.sides,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = borderColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    for (int i = 0; i <= (sides - 1); i++) {
      drawSide(i, radius, center, canvas, borderPaint);
    }
  }

  void drawSide(
      int i, double radius, Offset center, Canvas canvas, Paint borderPaint) {
    final angle = (i / sides) * pi * 2;
    final angleAngle = ((i + 1) / sides) * pi * 2;
    final offset = Offset(
      radius * cos(angle) + center.dx,
      radius * sin(angle) + center.dy,
    );
    final secondOffset = Offset(
      radius * cos(angleAngle) + center.dx,
      radius * sin(angleAngle) + center.dy,
    );
    canvas.drawLine(offset, secondOffset, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
