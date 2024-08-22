import 'package:carpet/Blocs/liquid_bloc.dart';
import 'package:carpet/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Liquid extends StatelessWidget {
  final bool isFlipped;
  final AnimationController controller;

  const Liquid({
    super.key,
    required this.isFlipped,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    const double height = 200.0;

    return GestureDetector(
      onTap: () {
        context.read<LiquidBloc>().openLiquidMenu(controller);
      },
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 2000),
          curve: Curves.elasticOut,
          transform: Matrix4.identity()
            ..translate(
              0.0,
              context.select<LiquidBloc, double>((bloc) {
                if (isFlipped) {
                  return -bloc.openValue - 100;
                } else {
                  return bloc.openValue + 100;
                }
              }),
            ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          height: height,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 370),
            decoration: BoxDecoration(
              color: context.select<LiquidBloc, Color?>((bloc) {
                if (bloc.isOpening) {
                  return Constants.liquidSecondBgColor;
                } else {
                  return Constants.liquidBgColor;
                }
              }),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Transform(
                  transform: Matrix4.identity()
                    ..scale(1.0, isFlipped ? -1.0 : 1.0)
                    ..translate(
                        0.0, isFlipped ? -height * 2 + 50 : -height + 50),
                  child: Lottie.asset(
                    'Assets/Animations/liquid.json',
                    controller: controller,
                    animate: false,
                    height: height,
                    delegates: LottieDelegates(
                      values: [
                        ValueDelegate.color(
                          const ['**', 'Rectangle 1', 'Fill 1'],
                          value: context.select<LiquidBloc, Color?>((bloc) {
                            if (bloc.isOpening) {
                              return Constants.liquidSecondBgColor;
                            } else {
                              return Constants.liquidBgColor;
                            }
                          }),
                        ),
                        ValueDelegate.color(
                          const ['**', 'Shape 1', 'Fill 1'],
                          value: context.select<LiquidBloc, Color?>((bloc) {
                            if (bloc.isOpening) {
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
                // if (isFlipped)
                //   const SizedBox()
                // else
                //   Container(
                //     width: 88,
                //     height: 88,
                //     decoration: BoxDecoration(
                //       // color: context.select<LiquidBloc, Color?>((bloc) {
                //       //   if (bloc.isOpening) {
                //       //     return Colors.amber[200];
                //       //   } else {
                //       //     return Colors.white;
                //       //   }
                //       // }),
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //     child: Icon(
                //       context.select<LiquidBloc, IconData>((bloc) {
                //         if (bloc.isOpening) {
                //           return Icons.lock_open;
                //         } else {
                //           return Icons.lock;
                //         }
                //       }),
                //       color: Colors.pinkAccent,
                //     ),
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
