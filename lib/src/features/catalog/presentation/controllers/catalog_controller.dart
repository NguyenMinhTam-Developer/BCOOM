import 'package:get/get.dart';

import '../../../home/domain/entities/brand_list_entity.dart';
import '../../../home/domain/entities/collection_list_entity.dart';
import '../../../home/domain/usecases/get_brand_list_usecase.dart';
import '../../domain/entities/product_side_bar_entity.dart';
import '../../domain/entities/product_sub_side_bar_entity.dart';
import '../../domain/usecases/get_product_side_bar_usecase.dart';
import '../../domain/usecases/get_product_sub_side_bar_usecase.dart';
import '../pages/product_list_page.dart';

class CatalogController extends GetxController {
  final GetProductSideBarUseCase _getProductSideBarUseCase;
  final GetProductSubSideBarUseCase _getProductSubSideBarUseCase;

  final GetBrandListUseCase _getBrandListUseCase;

  CatalogController({
    required GetProductSideBarUseCase getProductSideBarUseCase,
    required GetProductSubSideBarUseCase getProductSubSideBarUseCase,
    required GetBrandListUseCase getBrandListUseCase,
  })  : _getProductSideBarUseCase = getProductSideBarUseCase,
        _getProductSubSideBarUseCase = getProductSubSideBarUseCase,
        _getBrandListUseCase = getBrandListUseCase;

  final RxBool isLoading = false.obs;
  final RxBool isExpanded = true.obs;

  final Rx<BrandListEntity?> brandList = Rx<BrandListEntity?>(null);
  final Rx<CollectionListEntity?> collectionList = Rx<CollectionListEntity?>(null);
  final RxList<ProductSideBarCategory> categoryList = <ProductSideBarCategory>[].obs;

  final Rxn<int> selectedBrandId = Rxn<int>(null);

  final Rxn<ProductSideBarCategory> selectedMainCategory = Rxn<ProductSideBarCategory>(null);
  final Rxn<ProductSubSideBarEntity> selectedSubCategory = Rxn<ProductSubSideBarEntity>(null);

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = true;

    await Future.wait([
      _loadCategoriesWithSubcategories(),
      _loadBrands(),
    ]);

    // Select first category by default
    if (categoryList.isNotEmpty) {
      selectedMainCategory.value = categoryList.first;
    }

    isLoading.value = false;
  }

  Future<void> _loadBrands() async {
    final brandsResult = await _getBrandListUseCase(GetBrandListParams());
    brandsResult.fold(
      (failure) => Get.snackbar(failure.title, failure.message),
      (entity) => brandList.value = entity,
    );
  }

  /// Loads all categories with their subcategories in parallel
  Future<void> _loadCategoriesWithSubcategories() async {
    // First, fetch the main categories
    final mainResult = await _getProductSideBarUseCase(
      GetProductSideBarParams(slug: 'tat-ca', type: 'category'),
    );

    mainResult.fold(
      (failure) => Get.snackbar(failure.title, failure.message),
      (entity) async {
        final categories = entity.categories;
        if (categories.isEmpty) return;

        // Fetch subcategories for all categories in parallel
        final subCategoryFutures = categories.map((category) {
          return _getProductSubSideBarUseCase(
            GetProductSubSideBarParams(
              slug: category.slug,
              type: 'category',
            ),
          );
        }).toList();

        final subCategoryResults = await Future.wait(subCategoryFutures);

        // Build updated categories with subcategories
        final updatedCategories = <ProductSideBarCategory>[];
        for (int i = 0; i < categories.length; i++) {
          final category = categories[i];

          subCategoryResults[i].fold(
            (failure) {
              // If subcategory fetch fails, keep category with empty children
              updatedCategories.add(category);
            },
            (subEntity) {
              // Create a ProductSubSideBarEntity for each child subcategory
              // Each entity contains the same prices/filters but different category
              final subEntities = subEntity.category.children.map((child) {
                return ProductSubSideBarEntity(
                  prices: subEntity.prices,
                  filters: subEntity.filters,
                  category: ProductSubSideBarCategory(
                    id: child.id,
                    name: child.name,
                    slug: child.slug,
                    parentCategoryId: child.parentCategoryId,
                    children: child.children.cast<ProductSubSideBarSubCategory>(),
                  ),
                );
              }).toList();

              // Create new category with subcategory entities
              updatedCategories.add(
                ProductSideBarCategory(
                  id: category.id,
                  name: category.name,
                  slug: category.slug,
                  parentCategoryId: category.parentCategoryId,
                  children: subEntities,
                ),
              );
            },
          );
        }

        categoryList.value = updatedCategories;

        // Set the selected category to the updated one with subcategories
        if (updatedCategories.isNotEmpty) {
          selectedMainCategory.value = updatedCategories.first;
        }
      },
    );
  }

  /// Called when user taps on a main category
  void onCategoryTap(ProductSideBarCategory category) {
    selectedMainCategory.value = category;

    if (selectedMainCategory.value?.children.isEmpty ?? false) {
      ProductListPage.navigateTo(slug: selectedMainCategory.value?.slug ?? '', collectionSlug: collectionList.value?.rows.first.slug ?? '');
    }
  }

  /// Called when user taps on a subcategory
  void onSubCategoryTap(ProductSubSideBarEntity subCategory) {
    selectedSubCategory.value = subCategory;
    ProductListPage.navigateTo(slug: subCategory.category.slug, collectionSlug: collectionList.value?.rows.first.slug ?? '');
  }
}
