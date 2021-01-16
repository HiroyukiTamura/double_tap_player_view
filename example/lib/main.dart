import 'package:flutter/material.dart';
import 'package:double_tap_player_view/double_tap_player_view.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:video_player/video_player.dart';
import 'package:after_layout/after_layout.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with AfterLayoutMixin {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..initialize().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Center(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: DoubleTapPlayerView(
                child: VideoPlayer(_controller),
              ),
            ),
          ),
        ),
      );

  @override
  void afterFirstLayout(BuildContext context) => _controller.play();
}
