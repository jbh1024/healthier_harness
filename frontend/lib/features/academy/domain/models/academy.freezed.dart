// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'academy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Academy _$AcademyFromJson(Map<String, dynamic> json) {
  return _Academy.fromJson(json);
}

/// @nodoc
mixin _$Academy {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get contactInfo => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this Academy to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Academy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AcademyCopyWith<Academy> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AcademyCopyWith<$Res> {
  factory $AcademyCopyWith(Academy value, $Res Function(Academy) then) =
      _$AcademyCopyWithImpl<$Res, Academy>;
  @useResult
  $Res call(
      {int id,
      String name,
      String? description,
      String? contactInfo,
      bool isActive});
}

/// @nodoc
class _$AcademyCopyWithImpl<$Res, $Val extends Academy>
    implements $AcademyCopyWith<$Res> {
  _$AcademyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Academy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? contactInfo = freezed,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      contactInfo: freezed == contactInfo
          ? _value.contactInfo
          : contactInfo // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AcademyImplCopyWith<$Res> implements $AcademyCopyWith<$Res> {
  factory _$$AcademyImplCopyWith(
          _$AcademyImpl value, $Res Function(_$AcademyImpl) then) =
      __$$AcademyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String? description,
      String? contactInfo,
      bool isActive});
}

/// @nodoc
class __$$AcademyImplCopyWithImpl<$Res>
    extends _$AcademyCopyWithImpl<$Res, _$AcademyImpl>
    implements _$$AcademyImplCopyWith<$Res> {
  __$$AcademyImplCopyWithImpl(
      _$AcademyImpl _value, $Res Function(_$AcademyImpl) _then)
      : super(_value, _then);

  /// Create a copy of Academy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? contactInfo = freezed,
    Object? isActive = null,
  }) {
    return _then(_$AcademyImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      contactInfo: freezed == contactInfo
          ? _value.contactInfo
          : contactInfo // ignore: cast_nullable_to_non_nullable
              as String?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AcademyImpl implements _Academy {
  const _$AcademyImpl(
      {required this.id,
      required this.name,
      this.description,
      this.contactInfo,
      this.isActive = true});

  factory _$AcademyImpl.fromJson(Map<String, dynamic> json) =>
      _$$AcademyImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final String? contactInfo;
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'Academy(id: $id, name: $name, description: $description, contactInfo: $contactInfo, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AcademyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.contactInfo, contactInfo) ||
                other.contactInfo == contactInfo) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, description, contactInfo, isActive);

  /// Create a copy of Academy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AcademyImplCopyWith<_$AcademyImpl> get copyWith =>
      __$$AcademyImplCopyWithImpl<_$AcademyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AcademyImplToJson(
      this,
    );
  }
}

abstract class _Academy implements Academy {
  const factory _Academy(
      {required final int id,
      required final String name,
      final String? description,
      final String? contactInfo,
      final bool isActive}) = _$AcademyImpl;

  factory _Academy.fromJson(Map<String, dynamic> json) = _$AcademyImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  String? get contactInfo;
  @override
  bool get isActive;

  /// Create a copy of Academy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AcademyImplCopyWith<_$AcademyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
