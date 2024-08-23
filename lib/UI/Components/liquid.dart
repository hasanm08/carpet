import 'package:carpet/Blocs/liquid_bloc.dart';
import 'package:carpet/UI/Components/Clippers/octagon_clipper.dart';
import 'package:carpet/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Liquid extends StatelessWidget {
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
  Widget build(BuildContext context) {
    

    return GestureDetector(
      onTap: !enable
          ? null
          : () {
        context.read<LiquidBloc>().openLiquidMenu(controller);
      },
      child: Center(
        child: ClipPath(
          clipper: OctagonClipper(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 2000),
            curve: Curves.elasticOut,
            transform: Matrix4.identity()
              ..translate(
                0.0,
                context.select<LiquidBloc?, double>((bloc) {
                  if (bloc == null) {
                    return 100;
                  }
                  if (isFlipped) {
                    return -bloc.openValue - 100;
                  } else {
                    return bloc.openValue + 100;
                  }
                }),
              ),
            // decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            height: height,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 370),
              decoration: BoxDecoration(
                color: context.select<LiquidBloc?, Color>((bloc) {
                  if (!enable) {
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
                  ..scale(1.0, isFlipped ? -1.0 : 1.0)
                  ..translate(0.0, isFlipped ? -height * 2 + 50 : -height + 50),
                child: !enable
                    ? SizedBox(
                        height: height,
                        width: height,
                      )
                    : SizedBox(
                        width: height,
                        child: Lottie.asset(
                          'Assets/Animations/liquid.json',
                          controller: controller,
                          fit: BoxFit.scaleDown,
                          animate: false,
                          height: height,
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
                              // value: Colors.red),
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
