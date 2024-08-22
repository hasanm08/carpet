import 'package:carpet/Components/carpet.dart';
import 'package:flutter/material.dart';

class CarpetsComponent extends StatelessWidget {
  const CarpetsComponent({
    super.key,
    required this.count,
    required this.duration,
  });
  final int count;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ...List.generate(
            count,
            (index) {
              return Carpet(
                index: index,
              initialDepth: -100,
              finalDepth: 0,
                duration: duration,
              );
            },
          )
        ],
      ),
    );
  }
}
