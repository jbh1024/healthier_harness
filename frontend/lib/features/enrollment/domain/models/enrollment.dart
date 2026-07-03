import 'package:freezed_annotation/freezed_annotation.dart';

part 'enrollment.freezed.dart';
part 'enrollment.g.dart';

@freezed
class Enrollment with _$Enrollment {
  const Enrollment._();

  const factory Enrollment({
    required int id,
    required int courseId,
    required String courseTitle,
    required String status,
    int? waitlistPosition,
  }) = _Enrollment;

  factory Enrollment.fromJson(Map<String, dynamic> json) =>
      _$EnrollmentFromJson(json);

  String get statusLabel {
    switch (status) {
      case 'PENDING':
        return '승인 대기';
      case 'APPROVED':
        return '수강 중';
      case 'REJECTED':
        return '거절됨';
      case 'CANCELLED':
        return '취소됨';
      case 'WAITLISTED':
        return '대기 #$waitlistPosition';
      default:
        return status;
    }
  }
}
