import 'faq_category_entity.dart';

class FaqCategoryListEntity {
  final List<FaqCategoryEntity> rows;
  final bool more;
  final int limit;
  final int total;

  FaqCategoryListEntity({
    required this.rows,
    required this.more,
    required this.limit,
    required this.total,
  });
}
