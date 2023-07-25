import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stories_app/cubit/instagram_stories_cubit.dart';
import 'package:stories_app/product/utils/kup_class.dart';

class StoryScreen extends StatelessWidget {
  final InstagramStoriesState instagramState;
  const StoryScreen({super.key, required this.instagramState});

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..rotateY(
          (instagramState.offset.dx * pi / 180),
        ),
      alignment: Alignment.center,
      child: Stack(
        children: [
          if (Kup.liste.length == 1) ...[Kup.liste[0]],
          if (Kup.liste.length == 2) ...[Kup.liste[0], Kup.liste[1]]
        ],
      ),
    );
  }
}
