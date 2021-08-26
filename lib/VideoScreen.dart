import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({
    Key key,
    @required this.videoFile,
  }) : super(key: key);

  final Future<File> videoFile;

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController _controller;
  bool initialized = false;

  @override
  void initState() {
    _initVideo();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _initVideo() async {
    final video = await widget.videoFile;
    _controller = VideoPlayerController.file(video)
    //المفروض عشان الفيديو يشتغل تاني لما يخلص
      ..setLooping(true)
      ..initialize().then((_) => setState(() => initialized = true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(

          child: initialized
              ? Scaffold(
            backgroundColor: Colors.black,
            body: Center(

              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                // هستخدم الويدجت دي عشان اظهر الفيديو
                child: VideoPlayer(_controller),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                setState(() {
                  // لو شغال وقفوا
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    //لو واقف شغلوا.
                    _controller.play();
                  }
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow
                ,color: Colors.black,
              ),
            ),
          )
          // لو لسه مستغلش ف دي تظهر, البتاعه بتاعت اللودينج دي
              : Center(child: CircularProgressIndicator()),
        ));
  }
}
