import 'dart:ui';

import 'package:hooks_riverpod/all.dart';

import 'double_tap_model.dart';

class DoubleTapViewModel extends StateNotifier<DoubleTapState> {
  DoubleTapViewModel(this.config) : super(DoubleTapState.initial());

  final ViewModelConfig config;

  void noteTapPosition(Offset value) =>
      state = state.noteTapPosition(value.dx, value.dy);

  void notifyTap(double widgetWidth) {
    if (isLastTapValid(widgetWidth)) state = state.appendDoubleTapEvent();
  }

  void notifyHideWidget(String doubleTapEventKey) {
    if (doubleTapEventKey != state.doubleTapEventKey)
      state = DoubleTapState.initial();
  }

  bool isLastTapValid(double widgetW) {
    final xFromCenter =
    config.lr == Lr.LEFT ? widgetW - state.lastTap.x : state.lastTap.x;
    return config.ignoreRangeFromCenter < xFromCenter;
  }
}