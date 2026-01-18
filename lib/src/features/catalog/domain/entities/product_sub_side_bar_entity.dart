class ProductSubSideBarResponse {
  final String status;
  final String description;
  final ProductSubSideBarEntity data;

  const ProductSubSideBarResponse({
    required this.status,
    required this.description,
    required this.data,
  });
}

class ProductSubSideBarEntity {
  final List<ProductSubSideBarPrice> prices;
  final List<ProductSubSideBarFilter> filters;
  final ProductSubSideBarCategory category;

  ProductSubSideBarEntity({
    required this.prices,
    required this.filters,
    required this.category,
  });
}

class ProductSubSideBarPrice {
  final num id;
  final String name;
  final num minPrice;
  final num maxPrice;
  final num totalProducts;

  ProductSubSideBarPrice({
    required this.id,
    required this.name,
    required this.minPrice,
    required this.maxPrice,
    required this.totalProducts,
  });
}

class ProductSubSideBarFilter {
  final num filterCategoryId;
  final String filterCategoryName;
  final List<ProductSubSideBarFilterItem> filters;

  ProductSubSideBarFilter({
    required this.filterCategoryId,
    required this.filterCategoryName,
    required this.filters,
  });
}

class ProductSubSideBarFilterItem {
  final num filterId;
  final String filterName;
  final num filterCount;

  ProductSubSideBarFilterItem({
    required this.filterId,
    required this.filterName,
    required this.filterCount,
  });
}

class ProductSubSideBarCategory {
  final num id;
  final String name;
  final String slug;
  final num? parentCategoryId;
  final List<ProductSubSideBarSubCategory> children;

  ProductSubSideBarCategory({
    required this.id,
    required this.name,
    required this.slug,
    this.parentCategoryId,
    required this.children,
  });
}

class ProductSubSideBarSubCategory {
  final num id;
  final String name;
  final String slug;
  final num? parentCategoryId;
  final List<dynamic> children;

  ProductSubSideBarSubCategory({
    required this.id,
    required this.name,
    required this.slug,
    this.parentCategoryId,
    required this.children,
  });
}
