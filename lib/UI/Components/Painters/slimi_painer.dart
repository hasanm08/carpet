import 'dart:math';

import 'package:flutter/material.dart';

class OctagonPainter extends CustomPainter {
  final Color borderColor;
  final double strokeWidth;
  final int? side;

  OctagonPainter({
    this.borderColor = Colors.indigo,
    this.strokeWidth = 1.0,
    this.side,
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

    if (side != null) {
      drawTriangle(side!, radius, center, canvas, borderPaint);
    } else {
      for (int i = 0; i < 8; i++) {
        drawTriangle(i, radius, center, canvas, borderPaint);
      }
    }
  }

  void drawTriangle(int side, double radius, Offset center, Canvas canvas,
      Paint borderPaint) {
    final startAngle = (side / 8) * pi * 2;
    final endAngle = ((side + 2) / 8) * pi * 2;

    final startOffset = Offset(
      radius * cos(startAngle) + center.dx,
      radius * sin(startAngle) + center.dy,
    );
    final endOffset = Offset(
      radius * cos(endAngle) + center.dx,
      radius * sin(endAngle) + center.dy,
    );

    canvas.drawLine(startOffset, center, borderPaint..color = Colors.blue);
    canvas.drawLine(center, endOffset, borderPaint);
    canvas.drawLine(endOffset, startOffset, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
