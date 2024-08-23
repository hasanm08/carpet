import 'package:carpet/Blocs/liquid_bloc.dart';
import 'package:carpet/UI/Components/Clippers/octagon_clipper.dart';
import 'package:carpet/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Liquid extends StatefulWidget {
  final bool isFlipped;
  final AnimationController controller;
  final bool enable;
  final double opacity;

  final double height;
  const Liquid({
    super.key,
    required this.isFlipped,
    required this.controller,
    this.height = 200.0,
    this.enable = true,
    this.opacity = 1.0,
  });

  @override
  State<Liquid> createState() => _LiquidState();
}

class _LiquidState extends State<Liquid> {
  @override
  void initState() {
    context.read<LiquidBloc>().height = widget.height;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var gapHeight = widget.height / 4;
    return GestureDetector(
      onTap: !widget.enable
          ? null
          : () {
              context.read<LiquidBloc>().openLiquidMenu(widget.controller);
            },
      child: Center(
        child: ClipPath(
          clipper: OctagonClipper(sides: 8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 2000),
            curve: Curves.elasticOut,
            transform: Matrix4.identity()
              ..translate(
                0.0,
                context.select<LiquidBloc?, double>((bloc) {
                  if (bloc == null) {
                    return gapHeight * 2;
                  }
                  if (widget.isFlipped) {
                    return -bloc.openValue - gapHeight * 2;
                  } else {
                    return bloc.openValue + gapHeight * 2;
                  }
                }),
              ),
            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            height: widget.height,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 370),
              decoration: BoxDecoration(
                color: context.select<LiquidBloc?, Color>((bloc) {
                  if (!widget.enable) {
                    return Constants.liquidBgColorWithOpacity;
                  }
                  if (bloc != null && bloc.isOpening) {
                    return Constants.liquidSecondBgColor;
                  } else {
                    return Constants.liquidBgColor;
                  }
                }),
                // borderRadius: BorderRadius.circular(16),
              ),
              child: Transform(
                transform: Matrix4.identity()
                  ..scale(1.0, widget.isFlipped ? -1.0 : 1.0)
                  ..translate(
                      0.0,
                      widget.isFlipped
                          ? -widget.height * 2 + gapHeight
                          : -widget.height + gapHeight),
                child: !widget.enable
                    ? SizedBox(
                        height: widget.height,
                        width: widget.height,
                      )
                    : SizedBox(
                        width: widget.height,
                        child: Lottie.asset(
                          'Assets/Animations/liquid.json',
                          controller: widget.controller,
                          fit: BoxFit.scaleDown,
                          animate: false,
                          height: widget.height,
                          delegates: LottieDelegates(
                            values: [
                              ValueDelegate.color(
                                const ['**', 'Rectangle 1', 'Fill 1'],
                                value:
                                    context.select<LiquidBloc?, Color>((bloc) {
                                  if (bloc != null && bloc.isOpening) {
                                    return Constants.liquidSecondBgColor;
                                  } else {
                                    return Constants.liquidBgColor;
                                  }
                                }),
                              ),
                              ValueDelegate.color(
                                const ['**', 'Shape 1', 'Fill 1'],
                                value:
                                    context.select<LiquidBloc?, Color>((bloc) {
                                  if (bloc != null && bloc.isOpening) {
                                    return Constants.liquidSecondBgColor;
                                  } else {
                                    return Constants.liquidBgColor;
                                  }
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
