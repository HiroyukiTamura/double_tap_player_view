# double_tap_player_view

Created to handle fast forward/rewind behavior by double tap and horizontal drag like a video player.  
This plugin is inspired to [DoubleTapPlayerView](https://github.com/vkay94/DoubleTapPlayerView).

# Sample
![sample_screenshot](https://github.com/HiroyukTamura/double_tap_player_view/blob/master/image/sample_screenshot.gif)

# Requirement
This plugin depends [riverpod](https://github.com/rrousselgit/river_pod).  
you must wrap root widget with `ProviderScope` to use.

```dart
void main() {
 runApp(ProviderScope(child: MyApp()));
}
```

# Params
```dart
DoubleTapPlayerView(
  doubleTapConfig: DoubleTapConfig.create(
    ignoreCenterWidth: 128, // width of the zone which the double tap event is not fired in center
    iconLeft: Icon(
      Icons.fast_rewind,
      color: Colors.white,
      size: 40,
    ),
    iconRight: Icon(
      Icons.fast_rewind,
      color: Colors.white,
      size: 40,
    ),
    curveBank: 40, // height of the oval curve bank
    ovalColor: Colors.white30,
    rippleColor: Colors.white30,
    rippleExpansionTime: const Duration(milliseconds: 400),
    expansionHoldingTime: const Duration(milliseconds: 200),
    fadeTime: const Duration(milliseconds: 100),
    customWidgetBuilder: (lr, tapCount) => Container(),
    labelBuilder: (lr, tapCount) => '',
    labelStyle: const TextStyle(color: Colors.white),
    onDoubleTap: () {},
  ),
  swipeConfig: SwipeConfig.create(
    @required  overlayBuilder: _overlay,
    onSwipeEnd: (SwipeData data) {},
    backDrop: Colors.black45,
  ),
  child: Container(),
);
```

# example

```dart
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
```
