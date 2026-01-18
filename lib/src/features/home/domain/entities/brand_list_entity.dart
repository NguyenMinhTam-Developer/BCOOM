import 'brand_entity.dart';

class BrandListEntity {
  final List<BrandEntity> rows;
  final bool more;
  final int limit;
  final int total;

  const BrandListEntity({
    required this.rows,
    required this.more,
    required this.limit,
    required this.total,
  });
}
