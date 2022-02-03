import 'package:double_tap_player_view/src/model/conf_pair.dart';
import 'package:flutter/material.dart';

import '../../double_tap_player_view.dart';
import 'double_tap_model.dart';

/// widget config for [DoubleTapPlayerView] about double tap event
class DoubleTapConfig {
  final ViewModelConfig vmConfL;
  final ViewModelConfig vmConfR;
  final TapCountWidgetBuilder? customWidgetBuilder;
  final Widget iconRight;
  final Widget iconLeft;
  final TextBuilder? labelBuilder;
  final TextStyle labelStyle;
  final Duration rippleExpansionTime;
  final Duration expansionHoldingTime;
  final Duration fadeTime;
  final Duration backDropAnimDuration;
  final double curveBank;
  final Color ovalColor;
  final Color rippleColor;
  final Color backDrop;
  final DoubleTapCallback? onDoubleTap;

  DoubleTapConfig._({
    required this.vmConfL,
    required this.vmConfR,
    required this.customWidgetBuilder,
    required this.iconRight,
    required this.iconLeft,
    required this.labelStyle,
    required this.labelBuilder,
    required this.rippleExpansionTime,
    required this.expansionHoldingTime,
    required this.backDropAnimDuration,
    required this.fadeTime,
    required this.curveBank,
    required this.ovalColor,
    required this.rippleColor,
    required this.backDrop,
    required this.onDoubleTap,
  });

  /// factory constructor of [DoubleTapConfig].
  /// [DoubleTapConfig] is widget config for [DoubleTapPlayerView] about double tap event
  factory DoubleTapConfig.create({
    double ignoreCenterWidth = 128,
    Widget iconRight = const Icon(
      Icons.fast_forward,
      color: Colors.white,
      size: 40,
    ),
    Widget iconLeft = const Icon(
      Icons.fast_rewind,
      color: Colors.white,
      size: 40,
    ),
    double curveBank = 40,
    Color ovalColor = Colors.white30,
    Color rippleColor = Colors.white30,
    Color backDrop = Colors.black26,
    Duration rippleExpansionTime = const Duration(milliseconds: 400),
    Duration expansionHoldingTime = const Duration(milliseconds: 200),
    Duration fadeTime = const Duration(milliseconds: 100),
    Duration backDropAnimDuration = const Duration(milliseconds: 400),
    TapCountWidgetBuilder? customWidgetBuilder,
    TextBuilder? labelBuilder,
    TextStyle labelStyle = const TextStyle(color: Colors.white),
    DoubleTapCallback? onDoubleTap,
  }) {
    assert(0 <= curveBank);
    if (customWidgetBuilder != null)
      assert(labelBuilder == null,
          'if customWidgetBuilder is not null textBuilder must be null.'); //todo XOR CHECK
    return DoubleTapConfig._(
      vmConfL: ViewModelConfig(
        lr: Lr.LEFT,
        ignoreRangeFromCenter: ignoreCenterWidth / 2,
      ),
      vmConfR: ViewModelConfig(
        lr: Lr.RIGHT,
        ignoreRangeFromCenter: ignoreCenterWidth / 2,
      ),
      customWidgetBuilder: customWidgetBuilder,
      iconRight: iconRight,
      iconLeft: iconLeft,
      labelBuilder: labelBuilder,
      labelStyle: labelStyle,
      rippleExpansionTime: rippleExpansionTime,
      expansionHoldingTime: expansionHoldingTime,
      backDropAnimDuration: backDropAnimDuration,
      fadeTime: fadeTime,
      curveBank: curveBank,
      ovalColor: ovalColor,
      rippleColor: rippleColor,
      onDoubleTap: onDoubleTap,
      backDrop: backDrop,
    );
  }

  ConfPair get confPair => ConfPair(vmConfR, vmConfL);
}
