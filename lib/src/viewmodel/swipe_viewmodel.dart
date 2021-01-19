import 'package:double_tap_player_view/src/model/swipe_data.dart';
import 'package:double_tap_player_view/src/model/swipe_model.dart';
import 'package:hooks_riverpod/all.dart';

class SwipeViewModel extends StateNotifier<SwipeModel> {
  SwipeViewModel() : super(const SwipeModel());

  void setStart(double dx) =>
      state = state.copyWith(data: SwipeData(startDx: dx, currentDx: 0));

  void update(double dx) => state = state.copyWith.data(currentDx: dx);

  void clear() => state = state.copyWith(data: null);
}
