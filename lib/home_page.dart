import 'package:carpet/Blocs/liquid_bloc.dart';
import 'package:carpet/UI/Widgets/liquid_animation.dart';
import 'package:carpet/post_slider.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: ChangeNotifierProvider<LiquidBloc>(
            create: (context) => LiquidBloc(),
            builder: (context, _) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Scaffold(
                      backgroundColor: Colors.black,
                      appBar: AppBar(
                        title: const Text(
                          "Carpet App",
                          style: TextStyle(color: Colors.white),
                        ),
                        centerTitle: true,
                        backgroundColor: Colors.black,
                      ),
                      bottomNavigationBar: BottomNavigationBar(
                        type: BottomNavigationBarType.fixed,
                        backgroundColor: Colors.black,
                        unselectedLabelStyle:
                            const TextStyle(color: Colors.white),
                        selectedLabelStyle:
                            const TextStyle(color: Colors.white),
                        showSelectedLabels: true,
                        showUnselectedLabels: true,
                        fixedColor: Colors.white,
                        unselectedItemColor: Colors.white,
                        items: const [
                          BottomNavigationBarItem(
                              icon: Icon(
                                Icons.person_3_outlined,
                                color: Colors.white,
                              ),
                              label: "Account"),
                          BottomNavigationBarItem(
                              icon: Icon(
                                Icons.list_alt_rounded,
                                color: Colors.white,
                              ),
                              label: "Orders")
                        ],
                      ),
                      body: const Padding(
                          padding: EdgeInsets.all(16.0), child: PostsSlider())),
                  draggableMenu(context),
                ],
              );
            }),
      ),
    );
  }

  Widget draggableMenu(BuildContext context) {
    return context.select<LiquidBloc, Widget>((bloc) {
      return Positioned(
        left: bloc.details?.offset.dx ??
            (MediaQuery.of(context).size.width -
                    MediaQuery.of(context).padding.horizontal) /
                2,
        top: bloc.details?.offset.dy ??
            (MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.vertical) /
                2,
        child: Draggable(
          ignoringFeedbackPointer: true,
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
                : LiquidAnimation(animationController: _animationController),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
