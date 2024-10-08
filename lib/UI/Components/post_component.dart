import 'package:carpet/UI/Components/Painters/slimi_painter.dart';
import 'package:carpet/UI/Components/octagon_item.dart';
import 'package:flutter/material.dart';

class PostComponent extends StatefulWidget {
  const PostComponent({super.key, required this.index});
  final int index;

  @override
  State<PostComponent> createState() => _PostComponentState();
}

class _PostComponentState extends State<PostComponent> {
  final List<(String, String)> _images = [
    ("hasan", "Assets/Images/me.jpg"),
    ("adib", "Assets/Images/adib.jpg"),
    ("diba", "Assets/Images/diba.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.black,
          border: Border.all(width: 1, color: Colors.white)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              OctagonItem(
                  height: 32,
                  width: 32,
                  sides: (widget.index % 4) + 4,
                  child: Image.asset(
                    _images[widget.index].$2,
                    fit: BoxFit.cover,
                  )),
              const SizedBox(
                width: 8,
              ),
              Text(_images[widget.index].$1,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white))
            ],
          ),
          const Divider(),
          Center(
            child: SizedBox(
              height: 160,
              
              child: (widget.index != 1)
                  ? SizedBox(
                      height: 100,
                      child: Image.asset(
                        "Assets/Images/Kashan.jpg",
                      ),
                    )
                  : Column(
                      children: [
                        CustomPaint(
                          painter: SlimiPainter(borderColor: Colors.white),
                          child: const SizedBox(
                            height: 96,
                            width: 96,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const Text(
                          "No Image Found",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }
}
