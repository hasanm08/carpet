import 'package:carpet/Blocs/liquid_bloc.dart';
import 'package:carpet/UI/Components/liquid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1000,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<LiquidBloc>(
          create: (context) => LiquidBloc(),
          builder: (context, _) {
            return Stack(
              alignment: Alignment.center,
              children: <Widget>[
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
                                color: Colors.black,
                                fontSize: 40,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                ),
                Liquid(
                  isFlipped: true,
                  controller: _animationController,
                ),
                Liquid(
                  isFlipped: false,
                  controller: _animationController,
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 370),
                  child:
                      context.select<LiquidBloc, bool>((bloc) => bloc.isOpening)
                          ? null
                          : const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Tap To DisCover',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
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
          }),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
