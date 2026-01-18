import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/product_sub_side_bar_entity.dart';

class ProductSubSideBarResponseModel extends ProductSubSideBarResponse {
  const ProductSubSideBarResponseModel({
    required super.status,
    required super.description,
    required super.data,
  });

  factory ProductSubSideBarResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductSubSideBarResponseModel(
      status: JsonMapperUtils.safeParseString(json['status']),
      description: JsonMapperUtils.safeParseString(json['description']),
      data: ProductSubSideBarEntityModel.fromJson(
        JsonMapperUtils.safeParseMap(json['data']),
      ),
    );
  }
}

class ProductSubSideBarEntityModel extends ProductSubSideBarEntity {
  ProductSubSideBarEntityModel({
    required super.prices,
    required super.filters,
    required super.category,
  });

  factory ProductSubSideBarEntityModel.fromJson(Map<String, dynamic> json) {
    return ProductSubSideBarEntityModel(
      prices: JsonMapperUtils.safeParseList(
        json['prices'],
        mapper: (e) => ProductSubSideBarPriceModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
      filters: JsonMapperUtils.safeParseList(
        json['filters'],
        mapper: (e) => ProductSubSideBarFilterModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
      category: ProductSubSideBarCategoryModel.fromJson(
        JsonMapperUtils.safeParseMap(json['category']),
      ),
    );
  }
}

class ProductSubSideBarPriceModel extends ProductSubSideBarPrice {
  ProductSubSideBarPriceModel({
    required super.id,
    required super.name,
    required super.minPrice,
    required super.maxPrice,
    required super.totalProducts,
  });

  factory ProductSubSideBarPriceModel.fromJson(Map<String, dynamic> json) {
    return ProductSubSideBarPriceModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      name: JsonMapperUtils.safeParseString(json['name']),
      minPrice: JsonMapperUtils.safeParseDouble(json['min_price']),
      maxPrice: JsonMapperUtils.safeParseDouble(json['max_price']),
      totalProducts: JsonMapperUtils.safeParseInt(json['total_products']),
    );
  }
}

class ProductSubSideBarFilterModel extends ProductSubSideBarFilter {
  ProductSubSideBarFilterModel({
    required super.filterCategoryId,
    required super.filterCategoryName,
    required super.filters,
  });

  factory ProductSubSideBarFilterModel.fromJson(Map<String, dynamic> json) {
    return ProductSubSideBarFilterModel(
      filterCategoryId: JsonMapperUtils.safeParseInt(json['filter_category_id']),
      filterCategoryName: JsonMapperUtils.safeParseString(json['filter_category_name']),
      filters: JsonMapperUtils.safeParseList(
        json['filters'],
        mapper: (e) => ProductSubSideBarFilterItemModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
    );
  }
}

class ProductSubSideBarFilterItemModel extends ProductSubSideBarFilterItem {
  ProductSubSideBarFilterItemModel({
    required super.filterId,
    required super.filterName,
    required super.filterCount,
  });

  factory ProductSubSideBarFilterItemModel.fromJson(Map<String, dynamic> json) {
    return ProductSubSideBarFilterItemModel(
      filterId: JsonMapperUtils.safeParseInt(json['filter_id']),
      filterName: JsonMapperUtils.safeParseString(json['filter_name']),
      filterCount: JsonMapperUtils.safeParseInt(json['filter_count']),
    );
  }
}

class ProductSubSideBarCategoryModel extends ProductSubSideBarCategory {
  ProductSubSideBarCategoryModel({
    required super.id,
    required super.name,
    required super.slug,
    super.parentCategoryId,
    required super.children,
  });

  factory ProductSubSideBarCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductSubSideBarCategoryModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      name: JsonMapperUtils.safeParseString(json['name']),
      slug: JsonMapperUtils.safeParseString(json['slug']),
      parentCategoryId: json['parent_category_id'] != null ? JsonMapperUtils.safeParseInt(json['parent_category_id']) : null,
      children: JsonMapperUtils.safeParseList(
        json['children'],
        mapper: (e) => ProductSubSideBarSubCategoryModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
    );
  }
}

class ProductSubSideBarSubCategoryModel extends ProductSubSideBarSubCategory {
  ProductSubSideBarSubCategoryModel({
    required super.id,
    required super.name,
    required super.slug,
    super.parentCategoryId,
    required super.children,
  });

  factory ProductSubSideBarSubCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductSubSideBarSubCategoryModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      name: JsonMapperUtils.safeParseString(json['name']),
      slug: JsonMapperUtils.safeParseString(json['slug']),
      parentCategoryId: json['parent_category_id'] != null ? JsonMapperUtils.safeParseInt(json['parent_category_id']) : null,
      children: JsonMapperUtils.safeParseList(
        json['children'],
        mapper: (e) => e,
      ),
    );
  }
}
