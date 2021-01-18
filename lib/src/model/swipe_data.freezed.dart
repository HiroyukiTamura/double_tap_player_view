// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'swipe_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$SwipeDataTearOff {
  const _$SwipeDataTearOff();

// ignore: unused_element
  _SwipeData call({@required double startDx, @required double currentDx}) {
    return _SwipeData(
      startDx: startDx,
      currentDx: currentDx,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $SwipeData = _$SwipeDataTearOff();

/// @nodoc
mixin _$SwipeData {
  double get startDx;
  double get currentDx;

  @JsonKey(ignore: true)
  $SwipeDataCopyWith<SwipeData> get copyWith;
}

/// @nodoc
abstract class $SwipeDataCopyWith<$Res> {
  factory $SwipeDataCopyWith(SwipeData value, $Res Function(SwipeData) then) =
      _$SwipeDataCopyWithImpl<$Res>;
  $Res call({double startDx, double currentDx});
}

/// @nodoc
class _$SwipeDataCopyWithImpl<$Res> implements $SwipeDataCopyWith<$Res> {
  _$SwipeDataCopyWithImpl(this._value, this._then);

  final SwipeData _value;
  // ignore: unused_field
  final $Res Function(SwipeData) _then;

  @override
  $Res call({
    Object startDx = freezed,
    Object currentDx = freezed,
  }) {
    return _then(_value.copyWith(
      startDx: startDx == freezed ? _value.startDx : startDx as double,
      currentDx: currentDx == freezed ? _value.currentDx : currentDx as double,
    ));
  }
}

/// @nodoc
abstract class _$SwipeDataCopyWith<$Res> implements $SwipeDataCopyWith<$Res> {
  factory _$SwipeDataCopyWith(
          _SwipeData value, $Res Function(_SwipeData) then) =
      __$SwipeDataCopyWithImpl<$Res>;
  @override
  $Res call({double startDx, double currentDx});
}

/// @nodoc
class __$SwipeDataCopyWithImpl<$Res> extends _$SwipeDataCopyWithImpl<$Res>
    implements _$SwipeDataCopyWith<$Res> {
  __$SwipeDataCopyWithImpl(_SwipeData _value, $Res Function(_SwipeData) _then)
      : super(_value, (v) => _then(v as _SwipeData));

  @override
  _SwipeData get _value => super._value as _SwipeData;

  @override
  $Res call({
    Object startDx = freezed,
    Object currentDx = freezed,
  }) {
    return _then(_SwipeData(
      startDx: startDx == freezed ? _value.startDx : startDx as double,
      currentDx: currentDx == freezed ? _value.currentDx : currentDx as double,
    ));
  }
}

/// @nodoc
class _$_SwipeData implements _SwipeData {
  const _$_SwipeData({@required this.startDx, @required this.currentDx})
      : assert(startDx != null),
        assert(currentDx != null);

  @override
  final double startDx;
  @override
  final double currentDx;

  @override
  String toString() {
    return 'SwipeData(startDx: $startDx, currentDx: $currentDx)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SwipeData &&
            (identical(other.startDx, startDx) ||
                const DeepCollectionEquality()
                    .equals(other.startDx, startDx)) &&
            (identical(other.currentDx, currentDx) ||
                const DeepCollectionEquality()
                    .equals(other.currentDx, currentDx)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(startDx) ^
      const DeepCollectionEquality().hash(currentDx);

  @JsonKey(ignore: true)
  @override
  _$SwipeDataCopyWith<_SwipeData> get copyWith =>
      __$SwipeDataCopyWithImpl<_SwipeData>(this, _$identity);
}

abstract class _SwipeData implements SwipeData {
  const factory _SwipeData(
      {@required double startDx, @required double currentDx}) = _$_SwipeData;

  @override
  double get startDx;
  @override
  double get currentDx;
  @override
  @JsonKey(ignore: true)
  _$SwipeDataCopyWith<_SwipeData> get copyWith;
}
