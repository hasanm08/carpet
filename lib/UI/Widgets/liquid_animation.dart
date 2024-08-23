import 'package:carpet/Blocs/liquid_bloc.dart';
import 'package:carpet/UI/Components/liquid.dart';
import 'package:carpet/UI/Components/octagon_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LiquidAnimation extends StatelessWidget {
  const LiquidAnimation({
    super.key,
    required AnimationController animationController,
    this.opacity = 1,
    this.enable = true,
  }) : _animationController = animationController;

  final AnimationController _animationController;
  final double opacity;
  final bool enable;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LiquidBloc>(
        create: (context) => LiquidBloc(),
        builder: (context, _) {
          return const OctagonItem(
            height: 100,
            width: 10,
            child: Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
            ),
          );
          return Stack(
            alignment: Alignment.center,
            children: <Widget>[
              if (enable)
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 370),
                  child: context
                          .select<LiquidBloc, bool>((bloc) => !bloc.isOpening)
                      ? null
                      : const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Your Pass Code is: XXXX',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 4,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                ),
              Liquid(
                isFlipped: true,
                controller: _animationController,
                height: 100,
                enable: enable,
              ),
              Liquid(
                isFlipped: false,
                controller: _animationController,
                height: 100,
                enable: enable,
              ),
              if (enable)
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 370),
                  child:
                      context.select<LiquidBloc, bool>((bloc) => bloc.isOpening)
                          ? null
                          : const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Tap To Discover',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 4,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                ),
              // const CarpetsComponent(
              //   count: 4,
              //   duration: Duration(seconds: 2),
              // ),
            ],
          );
        });
  }
}
