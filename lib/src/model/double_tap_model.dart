import 'package:double_tap_player_view/src/model/lr.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'double_tap_model.freezed.dart';

@freezed
class DoubleTapState with _$DoubleTapState {

  const factory DoubleTapState({
    required int continuesTapTime,
    required int lastTapTime,
    required String doubleTapEventKey,
    Position? lastTap,
  }) = _DoubleTapState;

  factory DoubleTapState.initial() => const DoubleTapState(
        continuesTapTime: 0,
        lastTapTime: 0,
        doubleTapEventKey: INITIAL_KEY,
      );

  const DoubleTapState._();
  static const INITIAL_KEY = 'INITIAL';

  DoubleTapState appendDoubleTapEvent() => copyWith(
        doubleTapEventKey: const Uuid().v4(),
        continuesTapTime: continuesTapTime + 1,
      );

  DoubleTapState noteTapPosition(double dx, double dy) => copyWith(
        lastTap: Position(x: dx, y: dy),
        lastTapTime: DateTime.now().millisecondsSinceEpoch,
      );
}

@freezed
abstract class Position with _$Position {
  const factory Position({
    required double x,
    required double y,
  }) = _Position;
}

@freezed
abstract class ViewModelConfig with _$ViewModelConfig {
  const factory ViewModelConfig({
    required Lr lr,
    required double ignoreRangeFromCenter,
  }) = _ViewModelConfig;
}

extension PositionX on Position {
  Offset toOffset() => Offset(x, y);
}
