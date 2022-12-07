import 'package:flutter/material.dart';
import 'package:stories_app/cubit/instagram_stories_cubit.dart';
import 'package:stories_app/model/users_page.dart';
import 'package:stories_app/products/paddings.dart';
import 'package:stories_app/products/widgets/story_screen_padding.dart';

class StoryImage extends StatelessWidget {
  InstagramStoriesState state;
  Story gorsel;
  int i;
  StoryImage(
      {super.key, required this.state, required this.gorsel, required this.i});

  @override
  Widget build(BuildContext context) {
    return StoryScreenPadding(
      child: Container(
        color: Colors.black,
        child: Stack(children: [
          Image.asset(
            gorsel.storyName,
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
          ),
          Padding(
              padding: MyPaddings.storyScreenProfileInfoPadding,
              child: Row(
                children: [
                  CircleAvatar(
                      backgroundImage: state
                          .instagramUsers[state.kullanici! + i].profilePicture,
                      radius: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                        state.instagramUsers[state.kullanici! + i].username,
                        style: Theme.of(context).textTheme.subtitle1),
                  )
                ],
              )),
        ]),
      ),
    );
  }
}
