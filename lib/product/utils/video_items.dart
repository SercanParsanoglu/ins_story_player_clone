import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoItems extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping = true;
  final BuildContext context;
  Duration? videoPauseArea;
  late final ChewieController _chewieController = ChewieController(
    showControls: false,
    videoPlayerController: videoPlayerController,
    aspectRatio: MediaQuery.of(context).size.aspectRatio,
    autoInitialize: true,
    autoPlay: true,
    looping: true,
    errorBuilder: (context, errorMessage) {
      return Center(child: Text(errorMessage));
    },
  );
  VideoItems(
      {super.key,
      required this.videoPlayerController,
      this.videoPauseArea,
      required this.context});

  @override
  State<VideoItems> createState() => _VideoItemsState();
}

class _VideoItemsState extends State<VideoItems> {
  @override
  void dispose() {
    widget._chewieController.dispose();
    widget.videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Chewie chewie = Chewie(controller: widget._chewieController);

    return chewie;
  }
}
