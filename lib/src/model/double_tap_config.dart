import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../double_tap_player_view.dart';
import 'double_tap_model.dart';
import '../widgets.dart';
import 'package:flutter/widgets.dart';

class DoubleTapConfig {
  final ViewModelConfig vmConfL;
  final ViewModelConfig vmConfR;
  final TapCountWidgetBuilder customWidgetBuilder;
  final Icon iconRight;
  final Icon iconLeft;
  final TextBuilder textBuilder;
  final TextStyle textStyle;
  final Duration rippleExpansionTime;
  final Duration expansionHoldingTime;
  final Duration fadeTime;
  final double curveBank;
  final Color ovalColor;
  final Color rippleColor;
  final GestureTapCallback onDoubleTap;

  DoubleTapConfig._({
    @required this.vmConfL,
    @required this.vmConfR,
    @required this.customWidgetBuilder,
    @required this.iconRight,
    @required this.iconLeft,
    @required this.textBuilder,
    @required this.textStyle,
    @required this.rippleExpansionTime,
    @required this.expansionHoldingTime,
    @required this.fadeTime,
    @required this.curveBank,
    @required this.ovalColor,
    @required this.rippleColor,
    @required this.onDoubleTap,
  });

  factory DoubleTapConfig.create({
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
    TapCountWidgetBuilder customWidgetBuilder,
    TextBuilder textBuilder,
    TextStyle textStyle = const TextStyle(color: Colors.white),
    GestureTapCallback onDoubleTap,
  }) {
    assert(0 <= curveBank);
    if (customWidgetBuilder != null)
      assert(
          iconRight == null &&
              iconLeft == null &&
              textBuilder == null &&
              textStyle == null,
          'if customWidgetBuilder is not null, iconRight, iconLeft, textBuilder and textStyle must be null.');
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
      textBuilder: textBuilder,
      textStyle: textStyle,
      rippleExpansionTime: rippleExpansionTime,
      expansionHoldingTime: expansionHoldingTime,
      fadeTime: fadeTime,
      curveBank: curveBank,
      ovalColor: ovalColor,
      rippleColor: rippleColor,
      onDoubleTap: onDoubleTap,
    );
  }
}
