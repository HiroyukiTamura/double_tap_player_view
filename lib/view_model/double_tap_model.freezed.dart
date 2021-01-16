// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'double_tap_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$DoubleTapStateTearOff {
  const _$DoubleTapStateTearOff();

// ignore: unused_element
  _DoubleTapState call(
      {@required int continuesTapTime,
      Position lastTap,
      @required int lastTapTime,
      String doubleTapEventKey}) {
    return _DoubleTapState(
      continuesTapTime: continuesTapTime,
      lastTap: lastTap,
      lastTapTime: lastTapTime,
      doubleTapEventKey: doubleTapEventKey,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $DoubleTapState = _$DoubleTapStateTearOff();

/// @nodoc
mixin _$DoubleTapState {
  int get continuesTapTime;
  Position get lastTap;
  int get lastTapTime;
  String get doubleTapEventKey;

  @JsonKey(ignore: true)
  $DoubleTapStateCopyWith<DoubleTapState> get copyWith;
}

/// @nodoc
abstract class $DoubleTapStateCopyWith<$Res> {
  factory $DoubleTapStateCopyWith(
          DoubleTapState value, $Res Function(DoubleTapState) then) =
      _$DoubleTapStateCopyWithImpl<$Res>;
  $Res call(
      {int continuesTapTime,
      Position lastTap,
      int lastTapTime,
      String doubleTapEventKey});

  $PositionCopyWith<$Res> get lastTap;
}

/// @nodoc
class _$DoubleTapStateCopyWithImpl<$Res>
    implements $DoubleTapStateCopyWith<$Res> {
  _$DoubleTapStateCopyWithImpl(this._value, this._then);

  final DoubleTapState _value;
  // ignore: unused_field
  final $Res Function(DoubleTapState) _then;

  @override
  $Res call({
    Object continuesTapTime = freezed,
    Object lastTap = freezed,
    Object lastTapTime = freezed,
    Object doubleTapEventKey = freezed,
  }) {
    return _then(_value.copyWith(
      continuesTapTime: continuesTapTime == freezed
          ? _value.continuesTapTime
          : continuesTapTime as int,
      lastTap: lastTap == freezed ? _value.lastTap : lastTap as Position,
      lastTapTime:
          lastTapTime == freezed ? _value.lastTapTime : lastTapTime as int,
      doubleTapEventKey: doubleTapEventKey == freezed
          ? _value.doubleTapEventKey
          : doubleTapEventKey as String,
    ));
  }

  @override
  $PositionCopyWith<$Res> get lastTap {
    if (_value.lastTap == null) {
      return null;
    }
    return $PositionCopyWith<$Res>(_value.lastTap, (value) {
      return _then(_value.copyWith(lastTap: value));
    });
  }
}

/// @nodoc
abstract class _$DoubleTapStateCopyWith<$Res>
    implements $DoubleTapStateCopyWith<$Res> {
  factory _$DoubleTapStateCopyWith(
          _DoubleTapState value, $Res Function(_DoubleTapState) then) =
      __$DoubleTapStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {int continuesTapTime,
      Position lastTap,
      int lastTapTime,
      String doubleTapEventKey});

  @override
  $PositionCopyWith<$Res> get lastTap;
}

/// @nodoc
class __$DoubleTapStateCopyWithImpl<$Res>
    extends _$DoubleTapStateCopyWithImpl<$Res>
    implements _$DoubleTapStateCopyWith<$Res> {
  __$DoubleTapStateCopyWithImpl(
      _DoubleTapState _value, $Res Function(_DoubleTapState) _then)
      : super(_value, (v) => _then(v as _DoubleTapState));

  @override
  _DoubleTapState get _value => super._value as _DoubleTapState;

  @override
  $Res call({
    Object continuesTapTime = freezed,
    Object lastTap = freezed,
    Object lastTapTime = freezed,
    Object doubleTapEventKey = freezed,
  }) {
    return _then(_DoubleTapState(
      continuesTapTime: continuesTapTime == freezed
          ? _value.continuesTapTime
          : continuesTapTime as int,
      lastTap: lastTap == freezed ? _value.lastTap : lastTap as Position,
      lastTapTime:
          lastTapTime == freezed ? _value.lastTapTime : lastTapTime as int,
      doubleTapEventKey: doubleTapEventKey == freezed
          ? _value.doubleTapEventKey
          : doubleTapEventKey as String,
    ));
  }
}

/// @nodoc
class _$_DoubleTapState extends _DoubleTapState {
  const _$_DoubleTapState(
      {@required this.continuesTapTime,
      this.lastTap,
      @required this.lastTapTime,
      this.doubleTapEventKey})
      : assert(continuesTapTime != null),
        assert(lastTapTime != null),
        super._();

  @override
  final int continuesTapTime;
  @override
  final Position lastTap;
  @override
  final int lastTapTime;
  @override
  final String doubleTapEventKey;

  @override
  String toString() {
    return 'DoubleTapState(continuesTapTime: $continuesTapTime, lastTap: $lastTap, lastTapTime: $lastTapTime, doubleTapEventKey: $doubleTapEventKey)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DoubleTapState &&
            (identical(other.continuesTapTime, continuesTapTime) ||
                const DeepCollectionEquality()
                    .equals(other.continuesTapTime, continuesTapTime)) &&
            (identical(other.lastTap, lastTap) ||
                const DeepCollectionEquality()
                    .equals(other.lastTap, lastTap)) &&
            (identical(other.lastTapTime, lastTapTime) ||
                const DeepCollectionEquality()
                    .equals(other.lastTapTime, lastTapTime)) &&
            (identical(other.doubleTapEventKey, doubleTapEventKey) ||
                const DeepCollectionEquality()
                    .equals(other.doubleTapEventKey, doubleTapEventKey)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(continuesTapTime) ^
      const DeepCollectionEquality().hash(lastTap) ^
      const DeepCollectionEquality().hash(lastTapTime) ^
      const DeepCollectionEquality().hash(doubleTapEventKey);

  @JsonKey(ignore: true)
  @override
  _$DoubleTapStateCopyWith<_DoubleTapState> get copyWith =>
      __$DoubleTapStateCopyWithImpl<_DoubleTapState>(this, _$identity);
}

abstract class _DoubleTapState extends DoubleTapState {
  const _DoubleTapState._() : super._();
  const factory _DoubleTapState(
      {@required int continuesTapTime,
      Position lastTap,
      @required int lastTapTime,
      String doubleTapEventKey}) = _$_DoubleTapState;

  @override
  int get continuesTapTime;
  @override
  Position get lastTap;
  @override
  int get lastTapTime;
  @override
  String get doubleTapEventKey;
  @override
  @JsonKey(ignore: true)
  _$DoubleTapStateCopyWith<_DoubleTapState> get copyWith;
}

/// @nodoc
class _$PositionTearOff {
  const _$PositionTearOff();

// ignore: unused_element
  _Position call({@required double x, @required double y}) {
    return _Position(
      x: x,
      y: y,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $Position = _$PositionTearOff();

/// @nodoc
mixin _$Position {
  double get x;
  double get y;

  @JsonKey(ignore: true)
  $PositionCopyWith<Position> get copyWith;
}

/// @nodoc
abstract class $PositionCopyWith<$Res> {
  factory $PositionCopyWith(Position value, $Res Function(Position) then) =
      _$PositionCopyWithImpl<$Res>;
  $Res call({double x, double y});
}

/// @nodoc
class _$PositionCopyWithImpl<$Res> implements $PositionCopyWith<$Res> {
  _$PositionCopyWithImpl(this._value, this._then);

  final Position _value;
  // ignore: unused_field
  final $Res Function(Position) _then;

  @override
  $Res call({
    Object x = freezed,
    Object y = freezed,
  }) {
    return _then(_value.copyWith(
      x: x == freezed ? _value.x : x as double,
      y: y == freezed ? _value.y : y as double,
    ));
  }
}

/// @nodoc
abstract class _$PositionCopyWith<$Res> implements $PositionCopyWith<$Res> {
  factory _$PositionCopyWith(_Position value, $Res Function(_Position) then) =
      __$PositionCopyWithImpl<$Res>;
  @override
  $Res call({double x, double y});
}

/// @nodoc
class __$PositionCopyWithImpl<$Res> extends _$PositionCopyWithImpl<$Res>
    implements _$PositionCopyWith<$Res> {
  __$PositionCopyWithImpl(_Position _value, $Res Function(_Position) _then)
      : super(_value, (v) => _then(v as _Position));

  @override
  _Position get _value => super._value as _Position;

  @override
  $Res call({
    Object x = freezed,
    Object y = freezed,
  }) {
    return _then(_Position(
      x: x == freezed ? _value.x : x as double,
      y: y == freezed ? _value.y : y as double,
    ));
  }
}

/// @nodoc
class _$_Position implements _Position {
  const _$_Position({@required this.x, @required this.y})
      : assert(x != null),
        assert(y != null);

  @override
  final double x;
  @override
  final double y;

  @override
  String toString() {
    return 'Position(x: $x, y: $y)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Position &&
            (identical(other.x, x) ||
                const DeepCollectionEquality().equals(other.x, x)) &&
            (identical(other.y, y) ||
                const DeepCollectionEquality().equals(other.y, y)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(x) ^
      const DeepCollectionEquality().hash(y);

  @JsonKey(ignore: true)
  @override
  _$PositionCopyWith<_Position> get copyWith =>
      __$PositionCopyWithImpl<_Position>(this, _$identity);
}

abstract class _Position implements Position {
  const factory _Position({@required double x, @required double y}) =
      _$_Position;

  @override
  double get x;
  @override
  double get y;
  @override
  @JsonKey(ignore: true)
  _$PositionCopyWith<_Position> get copyWith;
}

/// @nodoc
class _$ViewModelConfigTearOff {
  const _$ViewModelConfigTearOff();

// ignore: unused_element
  _ViewModelConfig call(
      {@required Lr lr, @required double ignoreRangeFromCenter}) {
    return _ViewModelConfig(
      lr: lr,
      ignoreRangeFromCenter: ignoreRangeFromCenter,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $ViewModelConfig = _$ViewModelConfigTearOff();

/// @nodoc
mixin _$ViewModelConfig {
  Lr get lr;
  double get ignoreRangeFromCenter;

  @JsonKey(ignore: true)
  $ViewModelConfigCopyWith<ViewModelConfig> get copyWith;
}

/// @nodoc
abstract class $ViewModelConfigCopyWith<$Res> {
  factory $ViewModelConfigCopyWith(
          ViewModelConfig value, $Res Function(ViewModelConfig) then) =
      _$ViewModelConfigCopyWithImpl<$Res>;
  $Res call({Lr lr, double ignoreRangeFromCenter});
}

/// @nodoc
class _$ViewModelConfigCopyWithImpl<$Res>
    implements $ViewModelConfigCopyWith<$Res> {
  _$ViewModelConfigCopyWithImpl(this._value, this._then);

  final ViewModelConfig _value;
  // ignore: unused_field
  final $Res Function(ViewModelConfig) _then;

  @override
  $Res call({
    Object lr = freezed,
    Object ignoreRangeFromCenter = freezed,
  }) {
    return _then(_value.copyWith(
      lr: lr == freezed ? _value.lr : lr as Lr,
      ignoreRangeFromCenter: ignoreRangeFromCenter == freezed
          ? _value.ignoreRangeFromCenter
          : ignoreRangeFromCenter as double,
    ));
  }
}

/// @nodoc
abstract class _$ViewModelConfigCopyWith<$Res>
    implements $ViewModelConfigCopyWith<$Res> {
  factory _$ViewModelConfigCopyWith(
          _ViewModelConfig value, $Res Function(_ViewModelConfig) then) =
      __$ViewModelConfigCopyWithImpl<$Res>;
  @override
  $Res call({Lr lr, double ignoreRangeFromCenter});
}

/// @nodoc
class __$ViewModelConfigCopyWithImpl<$Res>
    extends _$ViewModelConfigCopyWithImpl<$Res>
    implements _$ViewModelConfigCopyWith<$Res> {
  __$ViewModelConfigCopyWithImpl(
      _ViewModelConfig _value, $Res Function(_ViewModelConfig) _then)
      : super(_value, (v) => _then(v as _ViewModelConfig));

  @override
  _ViewModelConfig get _value => super._value as _ViewModelConfig;

  @override
  $Res call({
    Object lr = freezed,
    Object ignoreRangeFromCenter = freezed,
  }) {
    return _then(_ViewModelConfig(
      lr: lr == freezed ? _value.lr : lr as Lr,
      ignoreRangeFromCenter: ignoreRangeFromCenter == freezed
          ? _value.ignoreRangeFromCenter
          : ignoreRangeFromCenter as double,
    ));
  }
}

/// @nodoc
class _$_ViewModelConfig implements _ViewModelConfig {
  const _$_ViewModelConfig(
      {@required this.lr, @required this.ignoreRangeFromCenter})
      : assert(lr != null),
        assert(ignoreRangeFromCenter != null);

  @override
  final Lr lr;
  @override
  final double ignoreRangeFromCenter;

  @override
  String toString() {
    return 'ViewModelConfig(lr: $lr, ignoreRangeFromCenter: $ignoreRangeFromCenter)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ViewModelConfig &&
            (identical(other.lr, lr) ||
                const DeepCollectionEquality().equals(other.lr, lr)) &&
            (identical(other.ignoreRangeFromCenter, ignoreRangeFromCenter) ||
                const DeepCollectionEquality().equals(
                    other.ignoreRangeFromCenter, ignoreRangeFromCenter)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(lr) ^
      const DeepCollectionEquality().hash(ignoreRangeFromCenter);

  @JsonKey(ignore: true)
  @override
  _$ViewModelConfigCopyWith<_ViewModelConfig> get copyWith =>
      __$ViewModelConfigCopyWithImpl<_ViewModelConfig>(this, _$identity);
}

abstract class _ViewModelConfig implements ViewModelConfig {
  const factory _ViewModelConfig(
      {@required Lr lr,
      @required double ignoreRangeFromCenter}) = _$_ViewModelConfig;

  @override
  Lr get lr;
  @override
  double get ignoreRangeFromCenter;
  @override
  @JsonKey(ignore: true)
  _$ViewModelConfigCopyWith<_ViewModelConfig> get copyWith;
}
