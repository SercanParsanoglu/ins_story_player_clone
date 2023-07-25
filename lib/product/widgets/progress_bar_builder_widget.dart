import 'package:flutter/material.dart';
import 'package:stories_app/cubit/instagram_stories_cubit.dart';
import 'package:stories_app/product/widgets/progress_bar_widget.dart';

class ProgressBarBuilder extends StatelessWidget {
  final InstagramStoriesState instagramState;
  const ProgressBarBuilder({super.key, required this.instagramState});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, sayac) {
        return Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width /
                  instagramState.instagramUsers[instagramState.kullanici!]
                      .storyImages.length,
              child: ProgressBar(
                yuzde: instagramState.storyTimerList[instagramState.kullanici!]
                    [sayac],
              ),
            ),
          ],
        );
      },
      itemCount: instagramState
          .instagramUsers[instagramState.kullanici!].storyImages.length,
    );
  }
}
