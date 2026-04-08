class Enrollment {
  final int id;
  final int courseId;
  final String courseTitle;
  final String status;
  final int? waitlistPosition;

  const Enrollment({
    required this.id,
    required this.courseId,
    required this.courseTitle,
    required this.status,
    this.waitlistPosition,
  });

  factory Enrollment.fromJson(Map<String, dynamic> json) => Enrollment(
        id: json['id'] as int,
        courseId: json['courseId'] as int,
        courseTitle: json['courseTitle'] as String,
        status: json['status'] as String,
        waitlistPosition: json['waitlistPosition'] as int?,
      );

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
