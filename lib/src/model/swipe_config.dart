import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../double_tap_player_view.dart';

typedef SwipeOverlayBuilder = Widget Function(SwipeData data);

class SwipeConfig {
  final OnDragCallback onDragEnd;
  final SwipeOverlayBuilder overlayBuilder;
  final Color backDrop;

  SwipeConfig._({
    this.onDragEnd,
    @required this.overlayBuilder,
    this.backDrop = Colors.black45,
  });

  factory SwipeConfig.create({
    OnDragCallback onDragEnd,
    @required SwipeOverlayBuilder overlayBuilder,
    Color backDrop = Colors.black45,
  }) => SwipeConfig._(
      onDragEnd: onDragEnd,
      overlayBuilder: overlayBuilder,
      backDrop: backDrop,
    );
}
