import 'package:carpet/UI/Components/octagon_item.dart';
import 'package:flutter/material.dart';

class AnimatedPolygon extends StatefulWidget {
  const AnimatedPolygon(
      {super.key, this.child, required this.height, this.width});
  final Widget? child;

  final double height;
  final double? width;
  @override
  State<AnimatedPolygon> createState() => _AnimatedPolygonState();
}

class _AnimatedPolygonState extends State<AnimatedPolygon>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _sidesAnimation;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450 * 8),
    );
    _sidesAnimation =
        Tween<double>(begin: 4.0, end: 12.0).animate(_animationController);
    _animationController.repeat();

    super.initState();
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
        builder: (context, _) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 370),
            height: _sidesAnimation.value + widget.height,
            child: OctagonItem(
              height: widget.height,
              width: widget.width,
              sides: _sidesAnimation.value.round(),
              child: widget.child,
            ),
          );
        });
  }
}
