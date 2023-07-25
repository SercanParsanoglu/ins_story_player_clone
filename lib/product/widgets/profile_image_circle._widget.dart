import 'package:flutter/material.dart';
import 'package:stories_app/model/user_model.dart';
import 'package:stories_app/view/story_gecisler.dart';
import 'package:stories_app/product/constants/color.dart';
import 'package:stories_app/product/constants/paddings.dart';

class CircleProfile extends StatelessWidget {
  final List<InstagramUser> instagramList;
  final int index;
  const CircleProfile({
    Key? key,
    required this.instagramList,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                if (instagramList[index].circleColor != Colors.grey) ...[
                  ProjectColor.lemon,
                  ProjectColor.milanoRed,
                ] else ...[
                  Colors.white,
                  Colors.grey,
                ]
              ])),
      child: GestureDetector(
        onTap: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StoryGecisler(
                  index: index,
                ),
              ));
        },
        child: Padding(
          padding: MyPaddings.circleAvatarPadding,
          child: CircleAvatar(
            backgroundImage: instagramList[index].profilePicture,
            radius: CircleAvatarRadius.normal,
          ),
        ),
      ),
    );
  }
}

class CircleAvatarRadius {
  static double small = 20;
  static double normal = 40;
  static double big = 100;
}
