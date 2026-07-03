// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Dashboard _$DashboardFromJson(Map<String, dynamic> json) {
  return _Dashboard.fromJson(json);
}

/// @nodoc
mixin _$Dashboard {
  int get totalMembers => throw _privateConstructorUsedError;
  int get totalCourses => throw _privateConstructorUsedError;
  int get activeEnrollments => throw _privateConstructorUsedError;
  List<InstructorStat> get instructorStats =>
      throw _privateConstructorUsedError;
  List<StudentStat> get studentStats => throw _privateConstructorUsedError;

  /// Serializes this Dashboard to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Dashboard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DashboardCopyWith<Dashboard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DashboardCopyWith<$Res> {
  factory $DashboardCopyWith(Dashboard value, $Res Function(Dashboard) then) =
      _$DashboardCopyWithImpl<$Res, Dashboard>;
  @useResult
  $Res call(
      {int totalMembers,
      int totalCourses,
      int activeEnrollments,
      List<InstructorStat> instructorStats,
      List<StudentStat> studentStats});
}

/// @nodoc
class _$DashboardCopyWithImpl<$Res, $Val extends Dashboard>
    implements $DashboardCopyWith<$Res> {
  _$DashboardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Dashboard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalMembers = null,
    Object? totalCourses = null,
    Object? activeEnrollments = null,
    Object? instructorStats = null,
    Object? studentStats = null,
  }) {
    return _then(_value.copyWith(
      totalMembers: null == totalMembers
          ? _value.totalMembers
          : totalMembers // ignore: cast_nullable_to_non_nullable
              as int,
      totalCourses: null == totalCourses
          ? _value.totalCourses
          : totalCourses // ignore: cast_nullable_to_non_nullable
              as int,
      activeEnrollments: null == activeEnrollments
          ? _value.activeEnrollments
          : activeEnrollments // ignore: cast_nullable_to_non_nullable
              as int,
      instructorStats: null == instructorStats
          ? _value.instructorStats
          : instructorStats // ignore: cast_nullable_to_non_nullable
              as List<InstructorStat>,
      studentStats: null == studentStats
          ? _value.studentStats
          : studentStats // ignore: cast_nullable_to_non_nullable
              as List<StudentStat>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DashboardImplCopyWith<$Res>
    implements $DashboardCopyWith<$Res> {
  factory _$$DashboardImplCopyWith(
          _$DashboardImpl value, $Res Function(_$DashboardImpl) then) =
      __$$DashboardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalMembers,
      int totalCourses,
      int activeEnrollments,
      List<InstructorStat> instructorStats,
      List<StudentStat> studentStats});
}

/// @nodoc
class __$$DashboardImplCopyWithImpl<$Res>
    extends _$DashboardCopyWithImpl<$Res, _$DashboardImpl>
    implements _$$DashboardImplCopyWith<$Res> {
  __$$DashboardImplCopyWithImpl(
      _$DashboardImpl _value, $Res Function(_$DashboardImpl) _then)
      : super(_value, _then);

  /// Create a copy of Dashboard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalMembers = null,
    Object? totalCourses = null,
    Object? activeEnrollments = null,
    Object? instructorStats = null,
    Object? studentStats = null,
  }) {
    return _then(_$DashboardImpl(
      totalMembers: null == totalMembers
          ? _value.totalMembers
          : totalMembers // ignore: cast_nullable_to_non_nullable
              as int,
      totalCourses: null == totalCourses
          ? _value.totalCourses
          : totalCourses // ignore: cast_nullable_to_non_nullable
              as int,
      activeEnrollments: null == activeEnrollments
          ? _value.activeEnrollments
          : activeEnrollments // ignore: cast_nullable_to_non_nullable
              as int,
      instructorStats: null == instructorStats
          ? _value._instructorStats
          : instructorStats // ignore: cast_nullable_to_non_nullable
              as List<InstructorStat>,
      studentStats: null == studentStats
          ? _value._studentStats
          : studentStats // ignore: cast_nullable_to_non_nullable
              as List<StudentStat>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DashboardImpl implements _Dashboard {
  const _$DashboardImpl(
      {required this.totalMembers,
      required this.totalCourses,
      required this.activeEnrollments,
      required final List<InstructorStat> instructorStats,
      required final List<StudentStat> studentStats})
      : _instructorStats = instructorStats,
        _studentStats = studentStats;

  factory _$DashboardImpl.fromJson(Map<String, dynamic> json) =>
      _$$DashboardImplFromJson(json);

  @override
  final int totalMembers;
  @override
  final int totalCourses;
  @override
  final int activeEnrollments;
  final List<InstructorStat> _instructorStats;
  @override
  List<InstructorStat> get instructorStats {
    if (_instructorStats is EqualUnmodifiableListView) return _instructorStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_instructorStats);
  }

  final List<StudentStat> _studentStats;
  @override
  List<StudentStat> get studentStats {
    if (_studentStats is EqualUnmodifiableListView) return _studentStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_studentStats);
  }

  @override
  String toString() {
    return 'Dashboard(totalMembers: $totalMembers, totalCourses: $totalCourses, activeEnrollments: $activeEnrollments, instructorStats: $instructorStats, studentStats: $studentStats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DashboardImpl &&
            (identical(other.totalMembers, totalMembers) ||
                other.totalMembers == totalMembers) &&
            (identical(other.totalCourses, totalCourses) ||
                other.totalCourses == totalCourses) &&
            (identical(other.activeEnrollments, activeEnrollments) ||
                other.activeEnrollments == activeEnrollments) &&
            const DeepCollectionEquality()
                .equals(other._instructorStats, _instructorStats) &&
            const DeepCollectionEquality()
                .equals(other._studentStats, _studentStats));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalMembers,
      totalCourses,
      activeEnrollments,
      const DeepCollectionEquality().hash(_instructorStats),
      const DeepCollectionEquality().hash(_studentStats));

  /// Create a copy of Dashboard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DashboardImplCopyWith<_$DashboardImpl> get copyWith =>
      __$$DashboardImplCopyWithImpl<_$DashboardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DashboardImplToJson(
      this,
    );
  }
}

abstract class _Dashboard implements Dashboard {
  const factory _Dashboard(
      {required final int totalMembers,
      required final int totalCourses,
      required final int activeEnrollments,
      required final List<InstructorStat> instructorStats,
      required final List<StudentStat> studentStats}) = _$DashboardImpl;

  factory _Dashboard.fromJson(Map<String, dynamic> json) =
      _$DashboardImpl.fromJson;

  @override
  int get totalMembers;
  @override
  int get totalCourses;
  @override
  int get activeEnrollments;
  @override
  List<InstructorStat> get instructorStats;
  @override
  List<StudentStat> get studentStats;

  /// Create a copy of Dashboard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DashboardImplCopyWith<_$DashboardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InstructorStat _$InstructorStatFromJson(Map<String, dynamic> json) {
  return _InstructorStat.fromJson(json);
}

/// @nodoc
mixin _$InstructorStat {
  String get instructorName => throw _privateConstructorUsedError;
  int get courseCount => throw _privateConstructorUsedError;
  int get totalEnrollments => throw _privateConstructorUsedError;

  /// Serializes this InstructorStat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InstructorStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InstructorStatCopyWith<InstructorStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InstructorStatCopyWith<$Res> {
  factory $InstructorStatCopyWith(
          InstructorStat value, $Res Function(InstructorStat) then) =
      _$InstructorStatCopyWithImpl<$Res, InstructorStat>;
  @useResult
  $Res call({String instructorName, int courseCount, int totalEnrollments});
}

/// @nodoc
class _$InstructorStatCopyWithImpl<$Res, $Val extends InstructorStat>
    implements $InstructorStatCopyWith<$Res> {
  _$InstructorStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InstructorStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? instructorName = null,
    Object? courseCount = null,
    Object? totalEnrollments = null,
  }) {
    return _then(_value.copyWith(
      instructorName: null == instructorName
          ? _value.instructorName
          : instructorName // ignore: cast_nullable_to_non_nullable
              as String,
      courseCount: null == courseCount
          ? _value.courseCount
          : courseCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalEnrollments: null == totalEnrollments
          ? _value.totalEnrollments
          : totalEnrollments // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InstructorStatImplCopyWith<$Res>
    implements $InstructorStatCopyWith<$Res> {
  factory _$$InstructorStatImplCopyWith(_$InstructorStatImpl value,
          $Res Function(_$InstructorStatImpl) then) =
      __$$InstructorStatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String instructorName, int courseCount, int totalEnrollments});
}

/// @nodoc
class __$$InstructorStatImplCopyWithImpl<$Res>
    extends _$InstructorStatCopyWithImpl<$Res, _$InstructorStatImpl>
    implements _$$InstructorStatImplCopyWith<$Res> {
  __$$InstructorStatImplCopyWithImpl(
      _$InstructorStatImpl _value, $Res Function(_$InstructorStatImpl) _then)
      : super(_value, _then);

  /// Create a copy of InstructorStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? instructorName = null,
    Object? courseCount = null,
    Object? totalEnrollments = null,
  }) {
    return _then(_$InstructorStatImpl(
      instructorName: null == instructorName
          ? _value.instructorName
          : instructorName // ignore: cast_nullable_to_non_nullable
              as String,
      courseCount: null == courseCount
          ? _value.courseCount
          : courseCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalEnrollments: null == totalEnrollments
          ? _value.totalEnrollments
          : totalEnrollments // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InstructorStatImpl implements _InstructorStat {
  const _$InstructorStatImpl(
      {required this.instructorName,
      required this.courseCount,
      required this.totalEnrollments});

  factory _$InstructorStatImpl.fromJson(Map<String, dynamic> json) =>
      _$$InstructorStatImplFromJson(json);

  @override
  final String instructorName;
  @override
  final int courseCount;
  @override
  final int totalEnrollments;

  @override
  String toString() {
    return 'InstructorStat(instructorName: $instructorName, courseCount: $courseCount, totalEnrollments: $totalEnrollments)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InstructorStatImpl &&
            (identical(other.instructorName, instructorName) ||
                other.instructorName == instructorName) &&
            (identical(other.courseCount, courseCount) ||
                other.courseCount == courseCount) &&
            (identical(other.totalEnrollments, totalEnrollments) ||
                other.totalEnrollments == totalEnrollments));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, instructorName, courseCount, totalEnrollments);

  /// Create a copy of InstructorStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InstructorStatImplCopyWith<_$InstructorStatImpl> get copyWith =>
      __$$InstructorStatImplCopyWithImpl<_$InstructorStatImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InstructorStatImplToJson(
      this,
    );
  }
}

abstract class _InstructorStat implements InstructorStat {
  const factory _InstructorStat(
      {required final String instructorName,
      required final int courseCount,
      required final int totalEnrollments}) = _$InstructorStatImpl;

  factory _InstructorStat.fromJson(Map<String, dynamic> json) =
      _$InstructorStatImpl.fromJson;

  @override
  String get instructorName;
  @override
  int get courseCount;
  @override
  int get totalEnrollments;

  /// Create a copy of InstructorStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InstructorStatImplCopyWith<_$InstructorStatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StudentStat _$StudentStatFromJson(Map<String, dynamic> json) {
  return _StudentStat.fromJson(json);
}

/// @nodoc
mixin _$StudentStat {
  String get studentName => throw _privateConstructorUsedError;
  int get enrolledCourses => throw _privateConstructorUsedError;

  /// Serializes this StudentStat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StudentStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StudentStatCopyWith<StudentStat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentStatCopyWith<$Res> {
  factory $StudentStatCopyWith(
          StudentStat value, $Res Function(StudentStat) then) =
      _$StudentStatCopyWithImpl<$Res, StudentStat>;
  @useResult
  $Res call({String studentName, int enrolledCourses});
}

/// @nodoc
class _$StudentStatCopyWithImpl<$Res, $Val extends StudentStat>
    implements $StudentStatCopyWith<$Res> {
  _$StudentStatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StudentStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentName = null,
    Object? enrolledCourses = null,
  }) {
    return _then(_value.copyWith(
      studentName: null == studentName
          ? _value.studentName
          : studentName // ignore: cast_nullable_to_non_nullable
              as String,
      enrolledCourses: null == enrolledCourses
          ? _value.enrolledCourses
          : enrolledCourses // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StudentStatImplCopyWith<$Res>
    implements $StudentStatCopyWith<$Res> {
  factory _$$StudentStatImplCopyWith(
          _$StudentStatImpl value, $Res Function(_$StudentStatImpl) then) =
      __$$StudentStatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String studentName, int enrolledCourses});
}

/// @nodoc
class __$$StudentStatImplCopyWithImpl<$Res>
    extends _$StudentStatCopyWithImpl<$Res, _$StudentStatImpl>
    implements _$$StudentStatImplCopyWith<$Res> {
  __$$StudentStatImplCopyWithImpl(
      _$StudentStatImpl _value, $Res Function(_$StudentStatImpl) _then)
      : super(_value, _then);

  /// Create a copy of StudentStat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentName = null,
    Object? enrolledCourses = null,
  }) {
    return _then(_$StudentStatImpl(
      studentName: null == studentName
          ? _value.studentName
          : studentName // ignore: cast_nullable_to_non_nullable
              as String,
      enrolledCourses: null == enrolledCourses
          ? _value.enrolledCourses
          : enrolledCourses // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StudentStatImpl implements _StudentStat {
  const _$StudentStatImpl(
      {required this.studentName, required this.enrolledCourses});

  factory _$StudentStatImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudentStatImplFromJson(json);

  @override
  final String studentName;
  @override
  final int enrolledCourses;

  @override
  String toString() {
    return 'StudentStat(studentName: $studentName, enrolledCourses: $enrolledCourses)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentStatImpl &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.enrolledCourses, enrolledCourses) ||
                other.enrolledCourses == enrolledCourses));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, studentName, enrolledCourses);

  /// Create a copy of StudentStat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentStatImplCopyWith<_$StudentStatImpl> get copyWith =>
      __$$StudentStatImplCopyWithImpl<_$StudentStatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudentStatImplToJson(
      this,
    );
  }
}

abstract class _StudentStat implements StudentStat {
  const factory _StudentStat(
      {required final String studentName,
      required final int enrolledCourses}) = _$StudentStatImpl;

  factory _StudentStat.fromJson(Map<String, dynamic> json) =
      _$StudentStatImpl.fromJson;

  @override
  String get studentName;
  @override
  int get enrolledCourses;

  /// Create a copy of StudentStat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StudentStatImplCopyWith<_$StudentStatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
