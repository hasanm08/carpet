import 'package:carpet/UI/Components/post_component.dart';
import 'package:flutter/material.dart';

class PostsSlider extends StatelessWidget {
  const PostsSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.maxFinite,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return PostComponent(index: index);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
        itemCount: 3,
      ),
    );
  }
}
