import 'package:freezed_annotation/freezed_annotation.dart';

part 'academy.freezed.dart';
part 'academy.g.dart';

@freezed
class Academy with _$Academy {
  const factory Academy({
    required int id,
    required String name,
    String? description,
    String? contactInfo,
    @Default(true) bool isActive,
  }) = _Academy;

  factory Academy.fromJson(Map<String, dynamic> json) =>
      _$AcademyFromJson(json);
}
