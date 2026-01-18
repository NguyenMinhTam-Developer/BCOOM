import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/my_point_history.dart';

class MyPointHistoryModel extends MyPointHistoryEntity {
  const MyPointHistoryModel({
    required super.userId,
    required super.title,
    required super.createdAt,
    required super.campaign,
  });

  factory MyPointHistoryModel.fromJson(Map<String, dynamic> json) {
    return MyPointHistoryModel(
      userId: JsonMapperUtils.safeParseInt(json['user_id']),
      title: JsonMapperUtils.safeParseString(json['title']),
      createdAt: JsonMapperUtils.safeParseDateTime(
        json['created_at'],
        defaultValue: DateTime.now(),
      ),
      campaign: CampaignModel.fromJson(
        JsonMapperUtils.safeParseMap(json['campaign']),
      ),
    );
  }
}

class CampaignModel extends CampaignEntity {
  const CampaignModel({
    required super.name,
    required super.points,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
      name: JsonMapperUtils.safeParseString(json['name']),
      points: JsonMapperUtils.safeParseInt(json['points']),
    );
  }
}

class MyPointHistoryPaginationModel extends MyPointHistoryPaginationEntity {
  const MyPointHistoryPaginationModel({
    required super.rows,
    required super.total,
    required super.limit,
  });

  factory MyPointHistoryPaginationModel.fromJson(Map<String, dynamic> json) {
    return MyPointHistoryPaginationModel(
      rows: JsonMapperUtils.safeParseList(
        json['rows'],
        mapper: (x) => MyPointHistoryModel.fromJson(
          JsonMapperUtils.safeParseMap(x),
        ),
      ),
      total: JsonMapperUtils.safeParseInt(json['total']),
      limit: JsonMapperUtils.safeParseInt(json['limit']),
    );
  }
}
