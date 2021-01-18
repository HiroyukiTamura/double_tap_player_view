import 'package:double_tap_player_view/double_tap_player_view.dart';
import 'package:flutter/material.dart';
import 'package:double_tap_player_view/src/model/swipe_config.dart';
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
              doubleTapConfig: DoubleTapConfig.create(),
              swipeConfig: SwipeConfig.create(overlayBuilder: _overlay),
              child: VideoPlayer(_controller),
            ),
          ),
        ),
      ));

  @override
  void afterFirstLayout(BuildContext context) => _controller.play();

  Widget _overlay(SwipeData data) {
    final dxDiff = (data.currentDx - data.startDx).toInt();
    Duration diffDuration = Duration(seconds: dxDiff);
    final prefix = diffDuration.isNegative ? '-' : '+';
    final positionText = '${prefix}${diffDuration.printDuration()}';
    final aimedDuration = diffDuration + Duration(minutes: 5);
    final diffText = aimedDuration.printDuration();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            positionText,
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4),
          Text(
            diffText,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

extension on Duration {
  /// ref: https://stackoverflow.com/a/54775297/8183034
  String printDuration() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(inMinutes.abs().remainder(60));
    String twoDigitSeconds = twoDigits(inSeconds.abs().remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
