import 'package:double_tap_player_view/src/model/double_tap_model.dart';
import 'package:double_tap_player_view/src/model/lr.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DoubleTapViewModel extends StateNotifier<DoubleTapState> {
  DoubleTapViewModel(this.config) : super(DoubleTapState.initial());

  final ViewModelConfig config;

  void noteTapPosition(double dx, double dy) =>
      state = state.noteTapPosition(dx, dy);

  void notifyTap(double widgetWidth) {
    if (isLastTapValid(widgetWidth)) state = state.appendDoubleTapEvent();
  }

  void notifyHideWidget(String doubleTapEventKey) {
    if (doubleTapEventKey == state.doubleTapEventKey)
      state = DoubleTapState.initial();
  }

  bool isLastTapValid(double widgetW) {
    final lastX = state.lastTap?.x;
    if (lastX == null) return false;

    final xFromCenter = config.lr == Lr.LEFT ? widgetW - lastX : lastX;
    return config.ignoreRangeFromCenter < xFromCenter;
  }
}
