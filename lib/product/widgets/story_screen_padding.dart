import 'package:flutter/material.dart';

class StoryScreenPadding extends StatelessWidget {
  Widget child;
  StoryScreenPadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 10),
      child: child,
    );
  }
}
