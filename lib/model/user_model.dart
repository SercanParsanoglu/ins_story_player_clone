import 'package:flutter/cupertino.dart';

class InstagramUser {
  List<Story> bakilmayanStoryler;
  String username;
  ImageProvider profilePicture;
  List<Story> storyImages;
  Color circleColor;
  InstagramUser(
      {required this.circleColor,
      required this.username,
      required this.profilePicture,
      required this.storyImages,
      required this.bakilmayanStoryler});

}

enum MediaType {
  image,
  video,
}

class Story {
  String? storyVideoName;
  final String storyName;
  Duration? storyDuration;
  MediaType? mediaType;

  Story(
      {required this.storyName,
      this.storyDuration,
      this.mediaType,
      this.storyVideoName});
}