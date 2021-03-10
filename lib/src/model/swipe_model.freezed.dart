// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'swipe_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SwipeModelTearOff {
  const _$SwipeModelTearOff();

  _SwipeModel call({SwipeData? data}) {
    return _SwipeModel(
      data: data,
    );
  }
}

/// @nodoc
const $SwipeModel = _$SwipeModelTearOff();

/// @nodoc
mixin _$SwipeModel {
  SwipeData? get data => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SwipeModelCopyWith<SwipeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SwipeModelCopyWith<$Res> {
  factory $SwipeModelCopyWith(
          SwipeModel value, $Res Function(SwipeModel) then) =
      _$SwipeModelCopyWithImpl<$Res>;
  $Res call({SwipeData? data});

  $SwipeDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$SwipeModelCopyWithImpl<$Res> implements $SwipeModelCopyWith<$Res> {
  _$SwipeModelCopyWithImpl(this._value, this._then);

  final SwipeModel _value;
  // ignore: unused_field
  final $Res Function(SwipeModel) _then;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as SwipeData?,
    ));
  }

  @override
  $SwipeDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $SwipeDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value));
    });
  }
}

/// @nodoc
abstract class _$SwipeModelCopyWith<$Res> implements $SwipeModelCopyWith<$Res> {
  factory _$SwipeModelCopyWith(
          _SwipeModel value, $Res Function(_SwipeModel) then) =
      __$SwipeModelCopyWithImpl<$Res>;
  @override
  $Res call({SwipeData? data});

  @override
  $SwipeDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$SwipeModelCopyWithImpl<$Res> extends _$SwipeModelCopyWithImpl<$Res>
    implements _$SwipeModelCopyWith<$Res> {
  __$SwipeModelCopyWithImpl(
      _SwipeModel _value, $Res Function(_SwipeModel) _then)
      : super(_value, (v) => _then(v as _SwipeModel));

  @override
  _SwipeModel get _value => super._value as _SwipeModel;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_SwipeModel(
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as SwipeData?,
    ));
  }
}

/// @nodoc
class _$_SwipeModel extends _SwipeModel {
  const _$_SwipeModel({this.data}) : super._();

  @override
  final SwipeData? data;

  @override
  String toString() {
    return 'SwipeModel(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SwipeModel &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(data);

  @JsonKey(ignore: true)
  @override
  _$SwipeModelCopyWith<_SwipeModel> get copyWith =>
      __$SwipeModelCopyWithImpl<_SwipeModel>(this, _$identity);
}

abstract class _SwipeModel extends SwipeModel {
  const factory _SwipeModel({SwipeData? data}) = _$_SwipeModel;
  const _SwipeModel._() : super._();

  @override
  SwipeData? get data => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SwipeModelCopyWith<_SwipeModel> get copyWith =>
      throw _privateConstructorUsedError;
}
