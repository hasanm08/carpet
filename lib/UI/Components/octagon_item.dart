import 'package:carpet/UI/Components/Clippers/octagon_clipper.dart';
import 'package:carpet/UI/Components/Painters/octagon_painter.dart';
import 'package:flutter/material.dart';

class OctagonItem extends StatelessWidget {
  const OctagonItem(
      {super.key, this.child, this.height, this.width, required this.sides});
  final Widget? child;
  final double? height;
  final double? width;
  final int sides;
  @override
  Widget build(BuildContext context) {
    var borderColor =
        [
            Colors.white,
            Colors.blue,
            Colors.green,
            Colors.pink
          ][sides % 4];
    return CustomPaint(
      painter: OctagonPainter(borderColor: borderColor, sides: sides),
      child: ClipPath(
          clipper: OctagonClipper(sides: sides),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 370),
            color: borderColor,
            height: height,
            width: height,
            child: child,
          )),
    );
  }
}
