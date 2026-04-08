class Academy {
  final int id;
  final String name;
  final String? description;
  final String? contactInfo;
  final bool isActive;

  const Academy({
    required this.id,
    required this.name,
    this.description,
    this.contactInfo,
    this.isActive = true,
  });

  factory Academy.fromJson(Map<String, dynamic> json) => Academy(
        id: json['id'] as int,
        name: json['name'] as String,
        description: json['description'] as String?,
        contactInfo: json['contactInfo'] as String?,
        isActive: json['isActive'] as bool? ?? true,
      );
}
