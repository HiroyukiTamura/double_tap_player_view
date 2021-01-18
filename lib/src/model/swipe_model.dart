import 'package:freezed_annotation/freezed_annotation.dart';

part 'swipe_model.freezed.dart';

@freezed
abstract class SwipeModel implements _$SwipeModel {
  const factory SwipeModel({
    SwipeData data,
  }) = _SwipeModel;

  const SwipeModel._();

  bool get isDragging => data != null;
}

@freezed
abstract class SwipeData with _$SwipeData {
  const factory SwipeData({
    @required double startDx,
    @required double currentDx,
  }) = _SwipeData;
}