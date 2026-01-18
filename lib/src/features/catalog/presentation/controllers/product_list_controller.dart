import 'package:bcoom/src/core/usecases/usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../home/domain/entities/collection_list_entity.dart';
import '../../../home/domain/usecases/get_collection_list_usecase.dart';
import '../../../product_detail/domain/entities/paginated_product_list_entity.dart';
import '../../../search/domain/entities/search_product_entity.dart';
import '../../domain/entities/product_sub_side_bar_entity.dart';
import '../../domain/usecases/get_product_list_usecase.dart';
import '../../domain/usecases/get_product_sub_side_bar_usecase.dart';

class ProductListController extends GetxController {
  final GetProductListUseCase _getProductListUseCase;
  final GetCollectionListUseCase _getCollectionListUseCase;
  final GetProductSubSideBarUseCase _getProductSubSideBarUseCase;

  ProductListController({
    required GetProductListUseCase getProductListUseCase,
    required GetCollectionListUseCase getCollectionListUseCase,
    required GetProductSubSideBarUseCase getProductSubSideBarUseCase,
  })  : _getProductListUseCase = getProductListUseCase,
        _getCollectionListUseCase = getCollectionListUseCase,
        _getProductSubSideBarUseCase = getProductSubSideBarUseCase;

  final RxBool isLoading = false.obs;
  final RxBool isLoadingProducts = false.obs;
  final RxBool isLoadingMore = false.obs;
  final Rxn<PaginatedProductListEntity> products = Rxn<PaginatedProductListEntity>(null);
  final Rxn<CollectionListEntity> collections = Rxn<CollectionListEntity>(null);
  final RxList<SearchProductEntity> productList = <SearchProductEntity>[].obs;
  final Rxn<ProductSubSideBarEntity> subSideBarData = Rxn<ProductSubSideBarEntity>(null);

  final ScrollController scrollController = ScrollController();
  final int pageLimit = 10;
  int currentOffset = 0;
  bool hasMoreData = true;
  String currentSlug = '';
  String currentCollectionSlug = '';

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = true;

    currentSlug = Get.parameters['slug'] ?? '';

    await Future.wait([
      _getCollections(),
      _getSubSideBarData(),
    ]);

    currentCollectionSlug = collections.value?.rows.first.slug ?? '';

    await _getProducts(
      slug: currentSlug,
      collectionSlug: currentCollectionSlug,
      offset: 0,
      limit: pageLimit,
      isLoadMore: false,
    );

    isLoading.value = false;

    // Setup scroll listener for load more
    scrollController.addListener(_scrollListener);
  }

  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.onClose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      loadMore();
    }
  }

  Future<void> _getCollections() async {
    final result = await _getCollectionListUseCase(NoParams());
    result.fold(
      (failure) => Get.snackbar(failure.title, failure.message),
      (collectionList) => collections.value = collectionList,
    );
  }

  Future<void> _getSubSideBarData() async {
    final result = await _getProductSubSideBarUseCase(
      GetProductSubSideBarParams(
        slug: currentSlug,
        type: 'category',
      ),
    );
    result.fold(
      (failure) => Get.snackbar(failure.title, failure.message),
      (entity) => subSideBarData.value = entity,
    );
  }

  Future<void> _getProducts({
    required String slug,
    required String collectionSlug,
    required int? offset,
    required int? limit,
    required bool isLoadMore,
  }) async {
    if (isLoadMore) {
      isLoadingMore.value = true;
    } else {
      isLoadingProducts.value = true;
    }

    final result = await _getProductListUseCase(
      GetProductListParams(
        slug: slug,
        collectionSlug: collectionSlug,
        offset: offset ?? 0,
        limit: limit ?? pageLimit,
      ),
    );

    result.fold(
      (failure) => Get.snackbar(failure.title, failure.message),
      (productsData) {
        products.value = productsData;

        if (isLoadMore) {
          // Append new products to existing list
          productList.addAll(productsData.rows);
        } else {
          // Replace with new products
          productList.value = productsData.rows;
        }

        // Update pagination state
        currentOffset = offset ?? 0;
        hasMoreData = productList.length < productsData.total;
      },
    );

    if (isLoadMore) {
      isLoadingMore.value = false;
    } else {
      isLoadingProducts.value = false;
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore.value || !hasMoreData) return;

    final nextOffset = currentOffset + pageLimit;

    await _getProducts(
      slug: currentSlug,
      collectionSlug: currentCollectionSlug,
      offset: nextOffset,
      limit: pageLimit,
      isLoadMore: true,
    );
  }

  void onTabTap(int value) async {
    // Reset pagination state when switching tabs
    currentOffset = 0;
    hasMoreData = true;
    productList.clear();

    // Update current collection slug
    currentCollectionSlug = collections.value?.rows[value].slug ?? '';

    await _getProducts(
      slug: currentSlug,
      collectionSlug: currentCollectionSlug,
      offset: 0,
      limit: pageLimit,
      isLoadMore: false,
    );
  }
}
