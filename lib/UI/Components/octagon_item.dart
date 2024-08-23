import 'package:carpet/UI/Components/Clippers/octagon_clipper.dart';
import 'package:carpet/UI/Components/Painters/octagon_painter.dart';
import 'package:flutter/material.dart';

class OctagonItem extends StatelessWidget {
  const OctagonItem({super.key, this.child, this.height, this.width});
  final Widget? child;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: OctagonPainter(borderColor: Colors.white, side: 0),
      child: ClipPath(
          clipper: OctagonClipper(side: 0),
          child: SizedBox(
            height: height,
            width: height,
            child: child,
          )),
    );
  }
}
