import 'paginated_product_list_entity.dart';

class RelatedProductsEntity {
  final PaginatedProductListEntity brand;
  final PaginatedProductListEntity category;
  final PaginatedProductListEntity seller;

  const RelatedProductsEntity({
    required this.brand,
    required this.category,
    required this.seller,
  });
}

