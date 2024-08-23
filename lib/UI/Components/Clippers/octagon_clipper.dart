import 'dart:math';

import 'package:flutter/material.dart';

class OctagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 0.0) / 2; // Adjust for potential stroke width

    for (int i = 0; i <= 7; i++) {
      final angle = (i / 8) * pi * 2;
      final offset = Offset(
        radius * cos(angle) + center.dx,
        radius * sin(angle) + center.dy,
      );

      if (i == 0) {
        path.moveTo(offset.dx, offset.dy);
      } else {
        path.lineTo(offset.dx, offset.dy);
      }
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
