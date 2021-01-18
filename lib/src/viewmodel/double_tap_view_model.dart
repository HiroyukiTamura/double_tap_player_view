
import 'package:hooks_riverpod/all.dart';
import '../model/lr.dart';
import '../model/double_tap_model.dart';

class DoubleTapViewModel extends StateNotifier<DoubleTapState> {
  DoubleTapViewModel(this.config) : super(DoubleTapState.initial());

  final ViewModelConfig config;

  void noteTapPosition(double dx, double dy) =>
      state = state.noteTapPosition(dx, dy);

  void notifyTap(double widgetWidth) {
    if (isLastTapValid(widgetWidth))
      state = state.appendDoubleTapEvent();
  }

  void notifyHideWidget(String doubleTapEventKey) {
    if (doubleTapEventKey == state.doubleTapEventKey)
      state = DoubleTapState.initial();
  }

  bool isLastTapValid(double widgetW) {
    if (state.lastTap == null)
      return false;

    final xFromCenter =
    config.lr == Lr.LEFT ? widgetW - state.lastTap.x : state.lastTap.x;
    return config.ignoreRangeFromCenter < xFromCenter;
  }
}