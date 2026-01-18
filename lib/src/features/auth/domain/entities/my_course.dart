enum CourseStatus {
  ongoing('On going'),
  completed('Completed'),
  saved('Saved');

  const CourseStatus(this.value);
  final String value;

  String toStringValue() => value;

  static CourseStatus? fromString(String? value) {
    if (value == null) return null;
    return CourseStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => CourseStatus.ongoing,
    );
  }
}

class MyCourseEntity {
  final int id;
  final int userId;
  final int courseListId;
  final DateTime? completedAt;
  final num? rewardPoints;
  final int createdBy;
  final int? updatedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String courseName;
  final String courseImage;
  final String userName;
  final String userPhone;
  final int lessonCount;

  const MyCourseEntity({
    required this.id,
    required this.userId,
    required this.courseListId,
    required this.completedAt,
    required this.rewardPoints,
    required this.createdBy,
    required this.updatedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.courseName,
    required this.courseImage,
    required this.userName,
    required this.userPhone,
    required this.lessonCount,
  });
}

class MyCoursePaginationEntity {
  final List<MyCourseEntity> rows;
  final bool more;
  final int limit;
  final int total;

  const MyCoursePaginationEntity({
    required this.rows,
    required this.more,
    required this.limit,
    required this.total,
  });
}
