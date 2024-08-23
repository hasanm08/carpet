import 'package:carpet/Blocs/liquid_bloc.dart';
import 'package:carpet/UI/Widgets/liquid_animation.dart';
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
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  context.select<LiquidBloc, Widget>((bloc) {
                    return Positioned(
                      left: bloc.details?.offset.dx ?? 0,
                      top: bloc.details?.offset.dy ?? 0,
                      child: Draggable(
                        feedback: LiquidAnimation(
                          animationController: _animationController,
                          enable: false,
                          opacity: .5,
                        ),
                        childWhenDragging: const SizedBox(),
                        onDragStarted: () {
                          bloc.isDragging = true;
                        },
                        onDragEnd: (details) {
                          bloc.isDragging = false;
                          bloc.details = details;
                        },
                        onDragUpdate: (details) {
                          // Update state or Bloc with details if needed
                        },
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 370),
                          child: bloc.isDragging
                              ? null
                              : LiquidAnimation(
                                  animationController: _animationController),
                        ),
                      ),
                    );
                  }),
                ],
              ),
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
