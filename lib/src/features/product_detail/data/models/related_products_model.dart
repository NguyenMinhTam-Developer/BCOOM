import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/related_products_entity.dart';
import 'paginated_product_list_model.dart';

class RelatedProductsModel extends RelatedProductsEntity {
  const RelatedProductsModel({
    required super.brand,
    required super.category,
    required super.seller,
  });

  factory RelatedProductsModel.fromJson(Map<String, dynamic> json) {
    // Handle null or missing keys
    final brandData = JsonMapperUtils.safeParseMapNullable(json['brand']);
    final categoryData = JsonMapperUtils.safeParseMapNullable(json['category']);
    final sellerData = JsonMapperUtils.safeParseMapNullable(json['seller']);

    return RelatedProductsModel(
      brand: brandData != null ? PaginatedProductListModel.fromJson(brandData) : PaginatedProductListModel.fromJson({}),
      category: categoryData != null ? PaginatedProductListModel.fromJson(categoryData) : PaginatedProductListModel.fromJson({}),
      seller: sellerData != null ? PaginatedProductListModel.fromJson(sellerData) : PaginatedProductListModel.fromJson({}),
    );
  }
}
