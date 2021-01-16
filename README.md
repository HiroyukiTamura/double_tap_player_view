# double_tap_player_view

Created to handle fast forward/rewind behavior by double tap like YouTube.
This plugin is inspired to [DoubleTapPlayerView](https://github.com/vkay94/DoubleTapPlayerView).

# Sample


# Requirement
This plugin depends [riverpod](https://github.com/rrousselgit/river_pod).
you must wrap root widget with ProviderScope to use.

```dart
void main() {
 runApp(ProviderScope(child: MyApp()));
}
```

# Params
```dart
DoubleTapPlayerView({
    Key key,
    double ignoreCenterWidth = 128,
    Icon iconRight = const Icon(
      Icons.fast_forward,
      color: Colors.white,
      size: 40,
    ),
    Icon iconLeft = const Icon(
      Icons.fast_rewind,
      color: Colors.white,
      size: 40,
    ),
    double curveBank = 40,
    Color ovalColor = Colors.white30,
    Color rippleColor = Colors.white30,
    Duration rippleExpansionTime = const Duration(milliseconds: 400),
    Duration expansionHoldingTime = const Duration(milliseconds: 200),
    Duration fadeTime = const Duration(milliseconds: 100),
    Widget Function(Lr lr, int tapCount) customWidgetBuilder,
    String Function(Lr lr, int tapCount) textBuilder,
    TextStyle textStyle = const TextStyle(color: Colors.white),
    Widget child,
  });
```

### `ignoreCenterWidth`
//todo screenshot

### `curveBank`
//todo screenshot

### colors
//todo screenshot

### durations
//todo screenshot