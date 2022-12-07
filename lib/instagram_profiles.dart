import 'package:flutter/material.dart';

import 'model/users_page.dart';
import 'utils/functions.dart';

List<InstagramUser> instagramUserList = [
  InstagramUser(
      circleColor: Colors.green,
      username: "Tina Montgomery",
      profilePicture: AssetImage(storyImageName(storyName: "1.jpg")),
      storyImages: [
        Story(
            storyName: storyImageName(storyName: "1.jpg"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.image),
        Story(
            storyVideoName: storyVideoName(storyName: "video2.mp4"),
            storyName: storyImageName(storyName: "video2image.JPG"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.video),
        Story(
            storyVideoName: storyVideoName(storyName: "video1.mp4"),
            storyName: storyImageName(storyName: "video1image.JPG"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.video),
      ],
      bakilmayanStoryler: [
        Story(
            storyName: storyImageName(storyName: "1.jpg"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.image),
        Story(
            storyVideoName: storyVideoName(storyName: "video2.mp4"),
            storyName: storyImageName(storyName: "video2image.JPG"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.video),
        Story(
            storyVideoName: storyVideoName(storyName: "video1.mp4"),
            storyName: storyImageName(storyName: "video1image.JPG"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.video),
      ]),
  InstagramUser(
      circleColor: Colors.orange,
      username: "Ryan Hull",
      profilePicture: AssetImage(storyImageName(storyName: "4.jpg")),
      storyImages: [
        Story(
            storyName: storyImageName(storyName: "4.jpg"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.image),
        Story(
            storyName: storyImageName(storyName: "5.jpg"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.image),
      ],
      bakilmayanStoryler: [
        Story(
            storyName: storyImageName(storyName: "4.jpg"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.image),
        Story(
            storyName: storyImageName(storyName: "5.jpg"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.image),
      ]),
  InstagramUser(
      circleColor: Colors.blue,
      username: "Paula Strickland",
      profilePicture: AssetImage(storyImageName(storyName: "7.jpg")),
      storyImages: [
        Story(
            storyVideoName: storyVideoName(storyName: "video3.mp4"),
            storyName: storyImageName(storyName: "video3image.JPG"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.video),
        Story(
            storyName: storyImageName(storyName: "7.jpg"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.image),
        Story(
            storyName: storyImageName(storyName: "8.jpg"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.image),
      ],
      bakilmayanStoryler: [
        Story(
            storyVideoName: storyVideoName(storyName: "video3.mp4"),
            storyName: storyImageName(storyName: "video3image.JPG"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.video),
        Story(
            storyName: storyImageName(storyName: "7.jpg"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.image),
        Story(
            storyName: storyImageName(storyName: "8.jpg"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.image),
      ]),
  InstagramUser(
      circleColor: Colors.red,
      username: "James Watt",
      profilePicture: AssetImage(storyImageName(storyName: "9.jpg")),
      storyImages: [
        Story(
            storyName: storyImageName(storyName: "9.jpg"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.image),
        Story(
            storyName: storyImageName(storyName: "10.jpg"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.image),
        Story(
            storyName: storyImageName(storyName: "11.jpg"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.image),
      ],
      bakilmayanStoryler: [
        Story(
            storyName: storyImageName(storyName: "9.jpg"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.image),
        Story(
            storyName: storyImageName(storyName: "10.jpg"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.image),
        Story(
            storyName: storyImageName(storyName: "11.jpg"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.image),
      ]),
  InstagramUser(
      circleColor: Colors.yellow,
      username: "Rick Sanchez",
      profilePicture: AssetImage(storyImageName(storyName: "12.jpg")),
      storyImages: [
        Story(
            storyName: storyImageName(storyName: "12.jpg"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.image),
        Story(
            storyName: storyImageName(storyName: "13.jpg"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.image),
        Story(
            storyName: storyImageName(storyName: "14.jpg"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.image),
      ],
      bakilmayanStoryler: [
        Story(
            storyName: storyImageName(storyName: "12.jpg"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.image),
        Story(
            storyName: storyImageName(storyName: "13.jpg"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.image),
        Story(
            storyName: storyImageName(storyName: "14.jpg"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.image),
      ]),
  InstagramUser(
      circleColor: Colors.black,
      username: "Walter White",
      profilePicture: AssetImage(storyImageName(storyName: "15.jpg")),
      storyImages: [
        Story(
            storyName: storyImageName(storyName: "15.jpg"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.image),
        Story(
            storyName: storyImageName(storyName: "16.jpg"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.image),
      ],
      bakilmayanStoryler: [
        Story(
            storyName: storyImageName(storyName: "15.jpg"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.image),
        Story(
            storyName: storyImageName(storyName: "16.jpg"),
            storyDuration: const Duration(milliseconds: 15),
            mediaType: MediaType.image),
      ]),
];
