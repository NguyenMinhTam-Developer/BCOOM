import 'collection_entity.dart';

class CollectionListEntity {
  final List<CollectionEntity> rows;
  final bool more;
  final int limit;
  final int total;

  const CollectionListEntity({
    required this.rows,
    required this.more,
    required this.limit,
    required this.total,
  });
}
