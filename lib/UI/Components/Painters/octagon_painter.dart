import 'dart:math';

import 'package:flutter/material.dart';

class OctagonPainter extends CustomPainter {
  final Color borderColor;
  final double strokeWidth;

  OctagonPainter({
    this.borderColor = Colors.red,
    this.strokeWidth = 1.0,
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

    // final angleMul = [0, 1, 2, 3, 4, 5, 6, 7, 8]; // For octagon

    for (int i = 0; i <= 7; i++) {
      final angle = (i / 8) * pi * 2;
      final angleAngle = ((i + 1) / 8) * pi * 2;
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
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
