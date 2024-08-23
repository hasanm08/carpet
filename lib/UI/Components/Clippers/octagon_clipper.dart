import 'dart:math';

import 'package:flutter/material.dart';

class OctagonClipper extends CustomClipper<Path> {
  final int? side;

  OctagonClipper({super.reclip, this.side});
  @override
  Path getClip(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 0.0) / 2; // Adjust for potential stroke width
    if (side != null) {
      drawSide(side!, radius, center, path);
      return path;
    }
    for (int i = 0; i <= 7; i++) {
      drawSide(i, radius, center, path);
    }

    path.close();
    return path;
  }

  void drawSide(int i, double radius, Offset center, Path path) {
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

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
