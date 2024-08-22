import 'dart:math';

import 'package:flutter/material.dart';

class Carpet extends StatefulWidget {
  final double initialDepth;
  final double finalDepth;
  final Duration duration;

  const Carpet({
    super.key,
    required this.initialDepth,
    required this.finalDepth,
    required this.duration,
  });

  @override
  State<Carpet> createState() => _CarpetState();
}

class _CarpetState extends State<Carpet> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _depthAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _depthAnimation =
        Tween<double>(begin: widget.initialDepth, end: widget.finalDepth)
            .animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        var value = _depthAnimation.value - widget.finalDepth;
        return Transform(
          transform: Matrix4.identity()
            ..setRotationZ(value == 0 ? -pi / 4 : 0)
            ..setEntry(3, 2, 0.001) //perspective
            // ..rotateY(-pi / 4)
            // ..translate(0, 0, -(depth)) // Adjust depth as needed
            ..scale(1.0 + _depthAnimation.value / 20),
          child: AnimatedAlign(
            duration: widget.duration,
            alignment: (value) < .5 ? Alignment.topLeft : Alignment.bottomRight,
            child: child,
          ),
        );
      },
      child: Container(
        width: 200,
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.brown,
          image: DecorationImage(
              image: AssetImage(
                "Assets/Images/Kashan.jpg",
              ),
              fit: BoxFit.fill),
        ),
      ),
    );
  }
}
