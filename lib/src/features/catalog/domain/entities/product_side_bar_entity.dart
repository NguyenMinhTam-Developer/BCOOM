import 'product_sub_side_bar_entity.dart';

class ProductSideBarResponse {
  final String status;
  final String description;
  final ProductSideBarEntity data;

  const ProductSideBarResponse({
    required this.status,
    required this.description,
    required this.data,
  });
}

class ProductSideBarEntity {
  final List<ProductSideBarPrice> prices;
  final List<ProductSideBarFilter> filters;
  final List<ProductSideBarCategory> categories;

  ProductSideBarEntity({
    required this.prices,
    required this.filters,
    required this.categories,
  });
}

class ProductSideBarPrice {
  final num id;
  final String name;
  final num minPrice;
  final num maxPrice;
  final num totalProducts;

  ProductSideBarPrice({
    required this.id,
    required this.name,
    required this.minPrice,
    required this.maxPrice,
    required this.totalProducts,
  });
}

class ProductSideBarFilter {
  final num filterCategoryId;
  final String filterCategoryName;
  final List<ProductSideBarFilterItem> filters;

  ProductSideBarFilter({
    required this.filterCategoryId,
    required this.filterCategoryName,
    required this.filters,
  });
}

class ProductSideBarFilterItem {
  final num filterId;
  final String filterName;
  final num filterCount;

  ProductSideBarFilterItem({
    required this.filterId,
    required this.filterName,
    required this.filterCount,
  });
}

class ProductSideBarCategory {
  final num id;
  final String name;
  final String slug;
  final num? parentCategoryId;
  final List<ProductSubSideBarEntity> children;

  ProductSideBarCategory({
    required this.id,
    required this.name,
    required this.slug,
    this.parentCategoryId,
    required this.children,
  });
}
