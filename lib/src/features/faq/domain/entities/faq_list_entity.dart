import 'faq_entity.dart';

class FaqListEntity {
  final List<FaqEntity> rows;
  final bool more;
  final String limit;
  final int total;

  FaqListEntity({
    required this.rows,
    required this.more,
    required this.limit,
    required this.total,
  });
}
