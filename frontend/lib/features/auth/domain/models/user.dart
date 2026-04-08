class User {
  final int id;
  final String email;
  final String name;
  final String? phone;
  final String? profileImageUrl;
  final String? thumbnailImageUrl;
  final List<UserAcademy> academies;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.phone,
    this.profileImageUrl,
    this.thumbnailImageUrl,
    this.academies = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int,
        email: json['email'] as String,
        name: json['name'] as String,
        phone: json['phone'] as String?,
        profileImageUrl: json['profileImageUrl'] as String?,
        thumbnailImageUrl: json['thumbnailImageUrl'] as String?,
        academies: (json['academies'] as List<dynamic>?)
                ?.map((e) => UserAcademy.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      );
}

class UserAcademy {
  final int academyId;
  final String academyName;
  final String role;
  final int remainingCredits;

  const UserAcademy({
    required this.academyId,
    required this.academyName,
    required this.role,
    required this.remainingCredits,
  });

  factory UserAcademy.fromJson(Map<String, dynamic> json) => UserAcademy(
        academyId: json['academyId'] as int,
        academyName: json['academyName'] as String,
        role: json['role'] as String,
        remainingCredits: json['remainingCredits'] as int,
      );
}
