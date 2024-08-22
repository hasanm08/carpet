import 'package:carpet/Components/carpet.dart';
import 'package:flutter/material.dart';

class CarpetsComponent extends StatelessWidget {
  const CarpetsComponent({
    super.key,
    required this.count,
  });
  final int count;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ...List.generate(
            count,
            (index) => const Carpet(
              initialDepth: -100,
              finalDepth: 0,
              duration: Duration(seconds: 5),
            ),
          )
        ],
      ),
    );
  }
}
