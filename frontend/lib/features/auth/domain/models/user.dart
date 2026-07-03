import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String email,
    required String name,
    String? phone,
    String? profileImageUrl,
    String? thumbnailImageUrl,
    @Default([]) List<UserAcademy> academies,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class UserAcademy with _$UserAcademy {
  const factory UserAcademy({
    required int academyId,
    required String academyName,
    required String role,
    required int remainingCredits,
  }) = _UserAcademy;

  factory UserAcademy.fromJson(Map<String, dynamic> json) =>
      _$UserAcademyFromJson(json);
}
