import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/my_course.dart';

class MyCourseModel extends MyCourseEntity {
  const MyCourseModel({
    required super.id,
    required super.userId,
    required super.courseListId,
    required super.completedAt,
    required super.rewardPoints,
    required super.createdBy,
    required super.updatedBy,
    required super.createdAt,
    required super.updatedAt,
    required super.courseName,
    required super.courseImage,
    required super.userName,
    required super.userPhone,
    required super.lessonCount,
  });

  factory MyCourseModel.fromJson(Map<String, dynamic> json) {
    return MyCourseModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      userId: JsonMapperUtils.safeParseInt(json['user_id']),
      courseListId: JsonMapperUtils.safeParseInt(json['course_list_id']),
      completedAt: JsonMapperUtils.safeParseDateTimeNullable(json['completed_at']),
      rewardPoints: JsonMapperUtils.safeParseIntNullable(json['reward_points']),
      createdBy: JsonMapperUtils.safeParseInt(json['created_by']),
      updatedBy: JsonMapperUtils.safeParseIntNullable(json['updated_by']),
      createdAt: JsonMapperUtils.safeParseDateTime(
        json['created_at'],
        defaultValue: DateTime.now(),
      ),
      updatedAt: JsonMapperUtils.safeParseDateTime(
        json['updated_at'],
        defaultValue: DateTime.now(),
      ),
      courseName: JsonMapperUtils.safeParseString(json['course_name']),
      courseImage: JsonMapperUtils.safeParseString(json['course_image']),
      userName: JsonMapperUtils.safeParseString(json['user_name']),
      userPhone: JsonMapperUtils.safeParseString(json['user_phone']),
      lessonCount: JsonMapperUtils.safeParseInt(json['lesson_count']),
    );
  }
}

class MyCoursePaginationModel extends MyCoursePaginationEntity {
  const MyCoursePaginationModel({
    required super.rows,
    required super.more,
    required super.limit,
    required super.total,
  });

  factory MyCoursePaginationModel.fromJson(Map<String, dynamic> json) {
    final pagination = JsonMapperUtils.safeParseMap(json['pagination']);
    return MyCoursePaginationModel(
      rows: JsonMapperUtils.safeParseList(
        json['rows'],
        mapper: (x) => MyCourseModel.fromJson(
          JsonMapperUtils.safeParseMap(x),
        ),
      ),
      more: JsonMapperUtils.safeParseBool(pagination['more']),
      limit: JsonMapperUtils.safeParseInt(json['limit']),
      total: JsonMapperUtils.safeParseInt(json['total']),
    );
  }
}
