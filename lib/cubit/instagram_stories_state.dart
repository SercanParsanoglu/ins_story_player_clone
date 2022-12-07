// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'instagram_stories_cubit.dart';

abstract class InstagramStoriesState {
  double increase;
  bool videoCalistir;
  VideoPlayerController? videoPlayerController;
  bool kontrol;
  double kupAci;
  Offset offset;
  List<InstagramUser> instagramUsers;
  List<List<Story>> storyList; //STRİNG STORY YAPILDI
  List<List<double>> storyTimerList;
  List<List<bool>> storyControllerList;
  int? kullanici;
  int profileViewer;
  bool wait;
  bool yeniGeldim;
  int degisti;
  InstagramStoriesState({
    required this.increase,
    required this.degisti,
    required this.videoPlayerController,
    required this.kontrol,
    required this.kupAci,
    required this.offset,
    required this.instagramUsers,
    required this.storyList,
    required this.storyTimerList,
    required this.storyControllerList,
    this.kullanici,
    required this.profileViewer,
    required this.wait,
    required this.yeniGeldim,
    required this.videoCalistir,
  });
}

class InstagramStoriesInitial extends InstagramStoriesState {
  InstagramStoriesInitial({
    required List<List<bool>> storyControllerList,
    required List<List<double>> storyTimerList,
    required List<List<Story>> storyList,
    required List<InstagramUser> instagramUsers,
  }) : super(
          increase: TimeBarSpeed.normal,
          videoCalistir: true,
          degisti: 0,
          videoPlayerController: null,
          kontrol: true,
          kupAci: 0,
          offset: Offset.zero,
          yeniGeldim: false,
          wait: false,
          storyControllerList: storyControllerList,
          profileViewer: 0,
          storyTimerList: storyTimerList,
          storyList: storyList,
          instagramUsers: instagramUsers,
        );
}

class MyInstagramStoriesState extends InstagramStoriesState {

  MyInstagramStoriesState({
    required double increase,
    required bool videoCalistir,
    required int degisti,
    required VideoPlayerController? videoplayercont,
    required bool kontrol,
    required double kupAci,
    required Offset offset,
    required bool wait,
    required List<List<bool>> storyControllerList,
    required int profileViewer,
    required List<InstagramUser> instagramUsers,
    required List<List<double>> storyTimerList,
    required List<List<Story>>storyList,
    required int? kullanici,
    required bool yeniGeldim,
  }) : super(
          increase: increase,
          videoCalistir: videoCalistir,
          degisti: degisti,
          videoPlayerController: videoplayercont,
          kontrol: kontrol,
          kupAci: kupAci,
          offset: offset,
          yeniGeldim: yeniGeldim,
          wait: wait,
          storyControllerList: storyControllerList,
          profileViewer: profileViewer,
          instagramUsers: instagramUsers,
          storyList: storyList,
          storyTimerList: storyTimerList,
          kullanici: kullanici,
        );
}
