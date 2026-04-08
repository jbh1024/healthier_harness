class Course {
  final int id;
  final String title;
  final String? description;
  final String instructorName;
  final int maxCapacity;
  final int currentEnrollment;
  final String enrollmentType;
  final String status;

  const Course({
    required this.id,
    required this.title,
    this.description,
    required this.instructorName,
    required this.maxCapacity,
    required this.currentEnrollment,
    required this.enrollmentType,
    required this.status,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String?,
        instructorName: json['instructorName'] as String,
        maxCapacity: json['maxCapacity'] as int,
        currentEnrollment: json['currentEnrollment'] as int,
        enrollmentType: json['enrollmentType'] as String,
        status: json['status'] as String,
      );

  bool get isFull => currentEnrollment >= maxCapacity;
  int get remainingSpots => maxCapacity - currentEnrollment;
}
