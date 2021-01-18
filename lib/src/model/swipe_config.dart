import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../double_tap_player_view.dart';

/// widget config for [DoubleTapPlayerView] about horizontal swipe event
class SwipeConfig {
  final OnDragCallback onDragEnd;
  final OnDragStartCallback onDragStart;
  final VoidCallback onDragCancel;
  final SwipeOverlayBuilder overlayBuilder;
  final Color backDrop;

  SwipeConfig._({
    this.onDragEnd,
    this.onDragStart,
    this.onDragCancel,
    @required this.overlayBuilder,
    this.backDrop = Colors.black45,
  });

  /// factory constructor of [SwipeConfig].
  /// [SwipeConfig] is the widget config for [DoubleTapPlayerView] about horizontal swipe event
  factory SwipeConfig.create({
    OnDragStartCallback onSwipeStart,
    VoidCallback onSwipeCancel,
    OnDragCallback onSwipeEnd,
    @required SwipeOverlayBuilder overlayBuilder,
    Color backDrop = Colors.black45,
  }) =>
      SwipeConfig._(
        onDragStart: onSwipeStart,
        onDragCancel: onSwipeCancel,
        onDragEnd: onSwipeEnd,
        overlayBuilder: overlayBuilder,
        backDrop: backDrop,
      );
}
