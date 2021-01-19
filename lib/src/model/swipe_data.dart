import 'package:freezed_annotation/freezed_annotation.dart';

part 'swipe_data.freezed.dart';

/// data model for swipe event.
/// [startDx] is [Offset.dx] of drag start. it's from [DragStartDetails.localPosition]
/// [currentDx] is [Offset.dx] of last drag event. it's from [DragUpdateDetails.localPosition]
@freezed
abstract class SwipeData with _$SwipeData {
  const factory SwipeData({
    @required double startDx,
    @required double currentDx,
  }) = _SwipeData;
}
