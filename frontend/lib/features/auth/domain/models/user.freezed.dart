// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  int get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get profileImageUrl => throw _privateConstructorUsedError;
  String? get thumbnailImageUrl => throw _privateConstructorUsedError;
  List<UserAcademy> get academies => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {int id,
      String email,
      String name,
      String? phone,
      String? profileImageUrl,
      String? thumbnailImageUrl,
      List<UserAcademy> academies});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = null,
    Object? phone = freezed,
    Object? profileImageUrl = freezed,
    Object? thumbnailImageUrl = freezed,
    Object? academies = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailImageUrl: freezed == thumbnailImageUrl
          ? _value.thumbnailImageUrl
          : thumbnailImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      academies: null == academies
          ? _value.academies
          : academies // ignore: cast_nullable_to_non_nullable
              as List<UserAcademy>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String email,
      String name,
      String? phone,
      String? profileImageUrl,
      String? thumbnailImageUrl,
      List<UserAcademy> academies});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = null,
    Object? phone = freezed,
    Object? profileImageUrl = freezed,
    Object? thumbnailImageUrl = freezed,
    Object? academies = null,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      thumbnailImageUrl: freezed == thumbnailImageUrl
          ? _value.thumbnailImageUrl
          : thumbnailImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      academies: null == academies
          ? _value._academies
          : academies // ignore: cast_nullable_to_non_nullable
              as List<UserAcademy>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {required this.id,
      required this.email,
      required this.name,
      this.phone,
      this.profileImageUrl,
      this.thumbnailImageUrl,
      final List<UserAcademy> academies = const []})
      : _academies = academies;

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final int id;
  @override
  final String email;
  @override
  final String name;
  @override
  final String? phone;
  @override
  final String? profileImageUrl;
  @override
  final String? thumbnailImageUrl;
  final List<UserAcademy> _academies;
  @override
  @JsonKey()
  List<UserAcademy> get academies {
    if (_academies is EqualUnmodifiableListView) return _academies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_academies);
  }

  @override
  String toString() {
    return 'User(id: $id, email: $email, name: $name, phone: $phone, profileImageUrl: $profileImageUrl, thumbnailImageUrl: $thumbnailImageUrl, academies: $academies)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.thumbnailImageUrl, thumbnailImageUrl) ||
                other.thumbnailImageUrl == thumbnailImageUrl) &&
            const DeepCollectionEquality()
                .equals(other._academies, _academies));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      email,
      name,
      phone,
      profileImageUrl,
      thumbnailImageUrl,
      const DeepCollectionEquality().hash(_academies));

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {required final int id,
      required final String email,
      required final String name,
      final String? phone,
      final String? profileImageUrl,
      final String? thumbnailImageUrl,
      final List<UserAcademy> academies}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  int get id;
  @override
  String get email;
  @override
  String get name;
  @override
  String? get phone;
  @override
  String? get profileImageUrl;
  @override
  String? get thumbnailImageUrl;
  @override
  List<UserAcademy> get academies;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserAcademy _$UserAcademyFromJson(Map<String, dynamic> json) {
  return _UserAcademy.fromJson(json);
}

/// @nodoc
mixin _$UserAcademy {
  int get academyId => throw _privateConstructorUsedError;
  String get academyName => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  int get remainingCredits => throw _privateConstructorUsedError;

  /// Serializes this UserAcademy to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserAcademy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserAcademyCopyWith<UserAcademy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserAcademyCopyWith<$Res> {
  factory $UserAcademyCopyWith(
          UserAcademy value, $Res Function(UserAcademy) then) =
      _$UserAcademyCopyWithImpl<$Res, UserAcademy>;
  @useResult
  $Res call(
      {int academyId, String academyName, String role, int remainingCredits});
}

/// @nodoc
class _$UserAcademyCopyWithImpl<$Res, $Val extends UserAcademy>
    implements $UserAcademyCopyWith<$Res> {
  _$UserAcademyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserAcademy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? academyId = null,
    Object? academyName = null,
    Object? role = null,
    Object? remainingCredits = null,
  }) {
    return _then(_value.copyWith(
      academyId: null == academyId
          ? _value.academyId
          : academyId // ignore: cast_nullable_to_non_nullable
              as int,
      academyName: null == academyName
          ? _value.academyName
          : academyName // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      remainingCredits: null == remainingCredits
          ? _value.remainingCredits
          : remainingCredits // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserAcademyImplCopyWith<$Res>
    implements $UserAcademyCopyWith<$Res> {
  factory _$$UserAcademyImplCopyWith(
          _$UserAcademyImpl value, $Res Function(_$UserAcademyImpl) then) =
      __$$UserAcademyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int academyId, String academyName, String role, int remainingCredits});
}

/// @nodoc
class __$$UserAcademyImplCopyWithImpl<$Res>
    extends _$UserAcademyCopyWithImpl<$Res, _$UserAcademyImpl>
    implements _$$UserAcademyImplCopyWith<$Res> {
  __$$UserAcademyImplCopyWithImpl(
      _$UserAcademyImpl _value, $Res Function(_$UserAcademyImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserAcademy
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? academyId = null,
    Object? academyName = null,
    Object? role = null,
    Object? remainingCredits = null,
  }) {
    return _then(_$UserAcademyImpl(
      academyId: null == academyId
          ? _value.academyId
          : academyId // ignore: cast_nullable_to_non_nullable
              as int,
      academyName: null == academyName
          ? _value.academyName
          : academyName // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      remainingCredits: null == remainingCredits
          ? _value.remainingCredits
          : remainingCredits // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserAcademyImpl implements _UserAcademy {
  const _$UserAcademyImpl(
      {required this.academyId,
      required this.academyName,
      required this.role,
      required this.remainingCredits});

  factory _$UserAcademyImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserAcademyImplFromJson(json);

  @override
  final int academyId;
  @override
  final String academyName;
  @override
  final String role;
  @override
  final int remainingCredits;

  @override
  String toString() {
    return 'UserAcademy(academyId: $academyId, academyName: $academyName, role: $role, remainingCredits: $remainingCredits)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserAcademyImpl &&
            (identical(other.academyId, academyId) ||
                other.academyId == academyId) &&
            (identical(other.academyName, academyName) ||
                other.academyName == academyName) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.remainingCredits, remainingCredits) ||
                other.remainingCredits == remainingCredits));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, academyId, academyName, role, remainingCredits);

  /// Create a copy of UserAcademy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserAcademyImplCopyWith<_$UserAcademyImpl> get copyWith =>
      __$$UserAcademyImplCopyWithImpl<_$UserAcademyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserAcademyImplToJson(
      this,
    );
  }
}

abstract class _UserAcademy implements UserAcademy {
  const factory _UserAcademy(
      {required final int academyId,
      required final String academyName,
      required final String role,
      required final int remainingCredits}) = _$UserAcademyImpl;

  factory _UserAcademy.fromJson(Map<String, dynamic> json) =
      _$UserAcademyImpl.fromJson;

  @override
  int get academyId;
  @override
  String get academyName;
  @override
  String get role;
  @override
  int get remainingCredits;

  /// Create a copy of UserAcademy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserAcademyImplCopyWith<_$UserAcademyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
