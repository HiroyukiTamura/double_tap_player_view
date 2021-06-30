import 'package:double_tap_player_view/double_tap_player_view.dart';
import 'package:flutter/material.dart';
import 'package:double_tap_player_view/src/model/swipe_config.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4')
      ..initialize().then((_) => setState(() {}));
    WidgetsBinding.instance
        ?.addPostFrameCallback((_) async => _controller.play());
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
                doubleTapConfig: DoubleTapConfig.create(onDoubleTap: (lr) {
                  print('double tapped: ${lr}');
                }),
                swipeConfig: SwipeConfig.create(overlayBuilder: _overlay),
                child: VideoPlayer(_controller),
              ),
            ),
          ),
        ),
      );

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
