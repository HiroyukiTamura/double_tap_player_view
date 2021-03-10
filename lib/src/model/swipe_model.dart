import 'package:double_tap_player_view/src/model/swipe_data.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'swipe_model.freezed.dart';

@freezed
class SwipeModel with _$SwipeModel {
  const factory SwipeModel({
    SwipeData? data,
  }) = _SwipeModel;

  const SwipeModel._();

  bool get isDragging => data != null;
}
