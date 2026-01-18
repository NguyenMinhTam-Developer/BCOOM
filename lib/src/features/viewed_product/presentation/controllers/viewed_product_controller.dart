import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/paginated_viewed_product_list_entity.dart';
import '../../domain/entities/viewed_product_entity.dart';
import '../../domain/usecases/get_viewed_products_usecase.dart';

class ViewedProductController extends GetxController {
  final GetViewedProductsUseCase _getViewedProductsUseCase;

  ViewedProductController({
    required GetViewedProductsUseCase getViewedProductsUseCase,
  }) : _getViewedProductsUseCase = getViewedProductsUseCase;

  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;

  final Rxn<PaginatedViewedProductListEntity> viewedProducts = Rxn<PaginatedViewedProductListEntity>(null);
  final RxList<ViewedProductEntity> rows = <ViewedProductEntity>[].obs;

  final ScrollController scrollController = ScrollController();

  final int pageLimit = 25;
  int currentOffset = 0;
  bool hasMoreData = true;

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = true;

    await _getViewedProducts(
      offset: 0,
      limit: pageLimit,
      isLoadMore: false,
    );

    isLoading.value = false;

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

  Future<void> _getViewedProducts({
    required int offset,
    required int limit,
    required bool isLoadMore,
  }) async {
    if (isLoadMore) {
      isLoadingMore.value = true;
    }

    final result = await _getViewedProductsUseCase(
      GetViewedProductsParams(
        offset: offset,
        limit: limit,
      ),
    );

    result.fold(
      (failure) => Get.snackbar(failure.title, failure.message),
      (data) {
        viewedProducts.value = data;

        if (isLoadMore) {
          rows.addAll(data.rows);
        } else {
          rows.value = data.rows;
        }

        currentOffset = offset;
        hasMoreData = data.pagination.more && rows.length < data.total;
      },
    );

    if (isLoadMore) {
      isLoadingMore.value = false;
    }
  }

  Future<void> refreshViewedProducts() async {
    currentOffset = 0;
    hasMoreData = true;
    await _getViewedProducts(
      offset: 0,
      limit: pageLimit,
      isLoadMore: false,
    );
  }

  Future<void> loadMore() async {
    if (isLoadingMore.value || !hasMoreData) return;

    final nextOffset = currentOffset + pageLimit;
    await _getViewedProducts(
      offset: nextOffset,
      limit: pageLimit,
      isLoadMore: true,
    );
  }
}

