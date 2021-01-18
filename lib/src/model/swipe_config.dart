import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../double_tap_player_view.dart';

/// widget config for [DoubleTapPlayerView] about horizontal swipe event
class SwipeConfig {
  final OnDragCallback onDragEnd;
  final SwipeOverlayBuilder overlayBuilder;
  final Color backDrop;

  SwipeConfig._({
    this.onDragEnd,
    @required this.overlayBuilder,
    this.backDrop = Colors.black45,
  });

  /// factory constructor of [SwipeConfig].
  /// [SwipeConfig] is the widget config for [DoubleTapPlayerView] about horizontal swipe event
  factory SwipeConfig.create({
    OnDragCallback onSwipeEnd,
    @required SwipeOverlayBuilder overlayBuilder,
    Color backDrop = Colors.black45,
  }) => SwipeConfig._(
      onDragEnd: onSwipeEnd,
      overlayBuilder: overlayBuilder,
      backDrop: backDrop,
    );
}
