enum PointHistoryType {
  accumulate('accumulate'),
  redeem('redeem');

  const PointHistoryType(this.value);
  final String value;

  String toStringValue() => value;

  static PointHistoryType? fromString(String? value) {
    if (value == null) return null;
    return PointHistoryType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => PointHistoryType.accumulate,
    );
  }
}

class MyPointHistoryEntity {
  final int userId;
  final String title;
  final DateTime createdAt;
  final CampaignEntity campaign;

  const MyPointHistoryEntity({
    required this.userId,
    required this.title,
    required this.createdAt,
    required this.campaign,
  });
}

class CampaignEntity {
  final String name;
  final num points;

  const CampaignEntity({
    required this.name,
    required this.points,
  });
}

class MyPointHistoryPaginationEntity {
  final List<MyPointHistoryEntity> rows;
  final int total;
  final int limit;

  const MyPointHistoryPaginationEntity({
    required this.rows,
    required this.total,
    required this.limit,
  });
}
