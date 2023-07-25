import 'package:flutter/material.dart';
import 'package:stories_app/cubit/instagram_stories_cubit.dart';
import 'package:stories_app/product/constants/paddings.dart';
import 'package:stories_app/product/widgets/story_screen_padding.dart';
import 'package:stories_app/product/utils/video_items.dart';
import 'package:video_player/video_player.dart';

class StoryVideo extends StatefulWidget {
  VideoPlayerController videoPlayerController;
  InstagramStoriesState state;
  int i;
  StoryVideo({
    super.key,
    required this.videoPlayerController,
    required this.state,
    required this.i,
  });

  @override
  State<StoryVideo> createState() => _StoryVideoState();
}

class _StoryVideoState extends State<StoryVideo> {
  @override
  Widget build(BuildContext context) {
    return StoryScreenPadding(
      child: Container(
        color: Colors.black,
        child: Stack(children: [
          VideoItems(
            context: context,
            videoPlayerController: widget.state.videoPlayerController!,
          ),
          Padding(
              padding: MyPaddings.storyScreenProfileInfoPadding,
              child: Row(
                children: [
                  CircleAvatar(
                      backgroundImage: widget
                          .state
                          .instagramUsers[widget.state.kullanici! + widget.i]
                          .profilePicture,
                      radius: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      widget
                          .state
                          .instagramUsers[widget.state.kullanici! + widget.i]
                          .username,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  )
                ],
              )),
        ]),
      ),
    );
  }
}
