import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/product_side_bar_entity.dart';
import 'product_sub_side_bar_model.dart';

class ProductSideBarResponseModel extends ProductSideBarResponse {
  const ProductSideBarResponseModel({
    required super.status,
    required super.description,
    required super.data,
  });

  factory ProductSideBarResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductSideBarResponseModel(
      status: JsonMapperUtils.safeParseString(json['status']),
      description: JsonMapperUtils.safeParseString(json['description']),
      data: ProductSideBarEntityModel.fromJson(
        JsonMapperUtils.safeParseMap(json['data']),
      ),
    );
  }
}

class ProductSideBarEntityModel extends ProductSideBarEntity {
  ProductSideBarEntityModel({
    required super.prices,
    required super.filters,
    required super.categories,
  });

  factory ProductSideBarEntityModel.fromJson(Map<String, dynamic> json) {
    return ProductSideBarEntityModel(
      prices: JsonMapperUtils.safeParseList(
        json['prices'],
        mapper: (e) => ProductSideBarPriceModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
      filters: JsonMapperUtils.safeParseList(
        json['filters'],
        mapper: (e) => ProductSideBarFilterModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
      categories: JsonMapperUtils.safeParseList(
        json['category'],
        mapper: (e) => ProductSideBarCategoryModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
    );
  }
}

class ProductSideBarPriceModel extends ProductSideBarPrice {
  ProductSideBarPriceModel({
    required super.id,
    required super.name,
    required super.minPrice,
    required super.maxPrice,
    required super.totalProducts,
  });

  factory ProductSideBarPriceModel.fromJson(Map<String, dynamic> json) {
    return ProductSideBarPriceModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      name: JsonMapperUtils.safeParseString(json['name']),
      minPrice: JsonMapperUtils.safeParseDouble(json['min_price']),
      maxPrice: JsonMapperUtils.safeParseDouble(json['max_price']),
      totalProducts: JsonMapperUtils.safeParseInt(json['total_products']),
    );
  }
}

class ProductSideBarFilterModel extends ProductSideBarFilter {
  ProductSideBarFilterModel({
    required super.filterCategoryId,
    required super.filterCategoryName,
    required super.filters,
  });

  factory ProductSideBarFilterModel.fromJson(Map<String, dynamic> json) {
    return ProductSideBarFilterModel(
      filterCategoryId: JsonMapperUtils.safeParseInt(json['filter_category_id']),
      filterCategoryName: JsonMapperUtils.safeParseString(json['filter_category_name']),
      filters: JsonMapperUtils.safeParseList(
        json['filters'],
        mapper: (e) => ProductSideBarFilterItemModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
    );
  }
}

class ProductSideBarFilterItemModel extends ProductSideBarFilterItem {
  ProductSideBarFilterItemModel({
    required super.filterId,
    required super.filterName,
    required super.filterCount,
  });

  factory ProductSideBarFilterItemModel.fromJson(Map<String, dynamic> json) {
    return ProductSideBarFilterItemModel(
      filterId: JsonMapperUtils.safeParseInt(json['filter_id']),
      filterName: JsonMapperUtils.safeParseString(json['filter_name']),
      filterCount: JsonMapperUtils.safeParseInt(json['filter_count']),
    );
  }
}

class ProductSideBarCategoryModel extends ProductSideBarCategory {
  ProductSideBarCategoryModel({
    required super.id,
    required super.name,
    required super.slug,
    super.parentCategoryId,
    required super.children,
  });

  factory ProductSideBarCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductSideBarCategoryModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      name: JsonMapperUtils.safeParseString(json['name']),
      slug: JsonMapperUtils.safeParseString(json['slug']),
      parentCategoryId: json['parent_category_id'] != null ? JsonMapperUtils.safeParseInt(json['parent_category_id']) : null,
      children: JsonMapperUtils.safeParseList(
        json['children'],
        mapper: (e) => ProductSubSideBarEntityModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
    );
  }
}
