// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'board_post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BoardPost _$BoardPostFromJson(Map<String, dynamic> json) {
  return _BoardPost.fromJson(json);
}

/// @nodoc
mixin _$BoardPost {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get authorName => throw _privateConstructorUsedError;
  bool get isPinned => throw _privateConstructorUsedError;
  int get viewCount => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;

  /// Serializes this BoardPost to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BoardPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BoardPostCopyWith<BoardPost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoardPostCopyWith<$Res> {
  factory $BoardPostCopyWith(BoardPost value, $Res Function(BoardPost) then) =
      _$BoardPostCopyWithImpl<$Res, BoardPost>;
  @useResult
  $Res call(
      {int id,
      String title,
      String authorName,
      bool isPinned,
      int viewCount,
      String createdAt});
}

/// @nodoc
class _$BoardPostCopyWithImpl<$Res, $Val extends BoardPost>
    implements $BoardPostCopyWith<$Res> {
  _$BoardPostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BoardPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? authorName = null,
    Object? isPinned = null,
    Object? viewCount = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      isPinned: null == isPinned
          ? _value.isPinned
          : isPinned // ignore: cast_nullable_to_non_nullable
              as bool,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BoardPostImplCopyWith<$Res>
    implements $BoardPostCopyWith<$Res> {
  factory _$$BoardPostImplCopyWith(
          _$BoardPostImpl value, $Res Function(_$BoardPostImpl) then) =
      __$$BoardPostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String authorName,
      bool isPinned,
      int viewCount,
      String createdAt});
}

/// @nodoc
class __$$BoardPostImplCopyWithImpl<$Res>
    extends _$BoardPostCopyWithImpl<$Res, _$BoardPostImpl>
    implements _$$BoardPostImplCopyWith<$Res> {
  __$$BoardPostImplCopyWithImpl(
      _$BoardPostImpl _value, $Res Function(_$BoardPostImpl) _then)
      : super(_value, _then);

  /// Create a copy of BoardPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? authorName = null,
    Object? isPinned = null,
    Object? viewCount = null,
    Object? createdAt = null,
  }) {
    return _then(_$BoardPostImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      isPinned: null == isPinned
          ? _value.isPinned
          : isPinned // ignore: cast_nullable_to_non_nullable
              as bool,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BoardPostImpl implements _BoardPost {
  const _$BoardPostImpl(
      {required this.id,
      required this.title,
      required this.authorName,
      this.isPinned = false,
      this.viewCount = 0,
      required this.createdAt});

  factory _$BoardPostImpl.fromJson(Map<String, dynamic> json) =>
      _$$BoardPostImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String authorName;
  @override
  @JsonKey()
  final bool isPinned;
  @override
  @JsonKey()
  final int viewCount;
  @override
  final String createdAt;

  @override
  String toString() {
    return 'BoardPost(id: $id, title: $title, authorName: $authorName, isPinned: $isPinned, viewCount: $viewCount, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoardPostImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, authorName, isPinned, viewCount, createdAt);

  /// Create a copy of BoardPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BoardPostImplCopyWith<_$BoardPostImpl> get copyWith =>
      __$$BoardPostImplCopyWithImpl<_$BoardPostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BoardPostImplToJson(
      this,
    );
  }
}

abstract class _BoardPost implements BoardPost {
  const factory _BoardPost(
      {required final int id,
      required final String title,
      required final String authorName,
      final bool isPinned,
      final int viewCount,
      required final String createdAt}) = _$BoardPostImpl;

  factory _BoardPost.fromJson(Map<String, dynamic> json) =
      _$BoardPostImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get authorName;
  @override
  bool get isPinned;
  @override
  int get viewCount;
  @override
  String get createdAt;

  /// Create a copy of BoardPost
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BoardPostImplCopyWith<_$BoardPostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BoardPostDetail _$BoardPostDetailFromJson(Map<String, dynamic> json) {
  return _BoardPostDetail.fromJson(json);
}

/// @nodoc
mixin _$BoardPostDetail {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get authorName => throw _privateConstructorUsedError;
  int get authorId => throw _privateConstructorUsedError;
  bool get isPinned => throw _privateConstructorUsedError;
  int get viewCount => throw _privateConstructorUsedError;
  List<Comment> get comments => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;

  /// Serializes this BoardPostDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BoardPostDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BoardPostDetailCopyWith<BoardPostDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoardPostDetailCopyWith<$Res> {
  factory $BoardPostDetailCopyWith(
          BoardPostDetail value, $Res Function(BoardPostDetail) then) =
      _$BoardPostDetailCopyWithImpl<$Res, BoardPostDetail>;
  @useResult
  $Res call(
      {int id,
      String title,
      String content,
      String authorName,
      int authorId,
      bool isPinned,
      int viewCount,
      List<Comment> comments,
      String createdAt});
}

/// @nodoc
class _$BoardPostDetailCopyWithImpl<$Res, $Val extends BoardPostDetail>
    implements $BoardPostDetailCopyWith<$Res> {
  _$BoardPostDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BoardPostDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? authorName = null,
    Object? authorId = null,
    Object? isPinned = null,
    Object? viewCount = null,
    Object? comments = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as int,
      isPinned: null == isPinned
          ? _value.isPinned
          : isPinned // ignore: cast_nullable_to_non_nullable
              as bool,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      comments: null == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Comment>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BoardPostDetailImplCopyWith<$Res>
    implements $BoardPostDetailCopyWith<$Res> {
  factory _$$BoardPostDetailImplCopyWith(_$BoardPostDetailImpl value,
          $Res Function(_$BoardPostDetailImpl) then) =
      __$$BoardPostDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String content,
      String authorName,
      int authorId,
      bool isPinned,
      int viewCount,
      List<Comment> comments,
      String createdAt});
}

/// @nodoc
class __$$BoardPostDetailImplCopyWithImpl<$Res>
    extends _$BoardPostDetailCopyWithImpl<$Res, _$BoardPostDetailImpl>
    implements _$$BoardPostDetailImplCopyWith<$Res> {
  __$$BoardPostDetailImplCopyWithImpl(
      _$BoardPostDetailImpl _value, $Res Function(_$BoardPostDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of BoardPostDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? authorName = null,
    Object? authorId = null,
    Object? isPinned = null,
    Object? viewCount = null,
    Object? comments = null,
    Object? createdAt = null,
  }) {
    return _then(_$BoardPostDetailImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as int,
      isPinned: null == isPinned
          ? _value.isPinned
          : isPinned // ignore: cast_nullable_to_non_nullable
              as bool,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      comments: null == comments
          ? _value._comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Comment>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BoardPostDetailImpl implements _BoardPostDetail {
  const _$BoardPostDetailImpl(
      {required this.id,
      required this.title,
      required this.content,
      required this.authorName,
      required this.authorId,
      this.isPinned = false,
      this.viewCount = 0,
      final List<Comment> comments = const [],
      required this.createdAt})
      : _comments = comments;

  factory _$BoardPostDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$BoardPostDetailImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String content;
  @override
  final String authorName;
  @override
  final int authorId;
  @override
  @JsonKey()
  final bool isPinned;
  @override
  @JsonKey()
  final int viewCount;
  final List<Comment> _comments;
  @override
  @JsonKey()
  List<Comment> get comments {
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_comments);
  }

  @override
  final String createdAt;

  @override
  String toString() {
    return 'BoardPostDetail(id: $id, title: $title, content: $content, authorName: $authorName, authorId: $authorId, isPinned: $isPinned, viewCount: $viewCount, comments: $comments, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoardPostDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            const DeepCollectionEquality().equals(other._comments, _comments) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      content,
      authorName,
      authorId,
      isPinned,
      viewCount,
      const DeepCollectionEquality().hash(_comments),
      createdAt);

  /// Create a copy of BoardPostDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BoardPostDetailImplCopyWith<_$BoardPostDetailImpl> get copyWith =>
      __$$BoardPostDetailImplCopyWithImpl<_$BoardPostDetailImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BoardPostDetailImplToJson(
      this,
    );
  }
}

abstract class _BoardPostDetail implements BoardPostDetail {
  const factory _BoardPostDetail(
      {required final int id,
      required final String title,
      required final String content,
      required final String authorName,
      required final int authorId,
      final bool isPinned,
      final int viewCount,
      final List<Comment> comments,
      required final String createdAt}) = _$BoardPostDetailImpl;

  factory _BoardPostDetail.fromJson(Map<String, dynamic> json) =
      _$BoardPostDetailImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get content;
  @override
  String get authorName;
  @override
  int get authorId;
  @override
  bool get isPinned;
  @override
  int get viewCount;
  @override
  List<Comment> get comments;
  @override
  String get createdAt;

  /// Create a copy of BoardPostDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BoardPostDetailImplCopyWith<_$BoardPostDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return _Comment.fromJson(json);
}

/// @nodoc
mixin _$Comment {
  int get id => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get authorName => throw _privateConstructorUsedError;
  int get authorId => throw _privateConstructorUsedError;
  int? get parentId => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Comment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommentCopyWith<Comment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentCopyWith<$Res> {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) then) =
      _$CommentCopyWithImpl<$Res, Comment>;
  @useResult
  $Res call(
      {int id,
      String content,
      String authorName,
      int authorId,
      int? parentId,
      String createdAt});
}

/// @nodoc
class _$CommentCopyWithImpl<$Res, $Val extends Comment>
    implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? authorName = null,
    Object? authorId = null,
    Object? parentId = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as int,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommentImplCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$$CommentImplCopyWith(
          _$CommentImpl value, $Res Function(_$CommentImpl) then) =
      __$$CommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String content,
      String authorName,
      int authorId,
      int? parentId,
      String createdAt});
}

/// @nodoc
class __$$CommentImplCopyWithImpl<$Res>
    extends _$CommentCopyWithImpl<$Res, _$CommentImpl>
    implements _$$CommentImplCopyWith<$Res> {
  __$$CommentImplCopyWithImpl(
      _$CommentImpl _value, $Res Function(_$CommentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? content = null,
    Object? authorName = null,
    Object? authorId = null,
    Object? parentId = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$CommentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as int,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommentImpl implements _Comment {
  const _$CommentImpl(
      {required this.id,
      required this.content,
      required this.authorName,
      required this.authorId,
      this.parentId,
      required this.createdAt});

  factory _$CommentImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentImplFromJson(json);

  @override
  final int id;
  @override
  final String content;
  @override
  final String authorName;
  @override
  final int authorId;
  @override
  final int? parentId;
  @override
  final String createdAt;

  @override
  String toString() {
    return 'Comment(id: $id, content: $content, authorName: $authorName, authorId: $authorId, parentId: $parentId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, content, authorName, authorId, parentId, createdAt);

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      __$$CommentImplCopyWithImpl<_$CommentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentImplToJson(
      this,
    );
  }
}

abstract class _Comment implements Comment {
  const factory _Comment(
      {required final int id,
      required final String content,
      required final String authorName,
      required final int authorId,
      final int? parentId,
      required final String createdAt}) = _$CommentImpl;

  factory _Comment.fromJson(Map<String, dynamic> json) = _$CommentImpl.fromJson;

  @override
  int get id;
  @override
  String get content;
  @override
  String get authorName;
  @override
  int get authorId;
  @override
  int? get parentId;
  @override
  String get createdAt;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
