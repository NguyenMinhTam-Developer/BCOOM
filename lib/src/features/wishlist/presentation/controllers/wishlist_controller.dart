import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/entities/paginated_wishlist_product_list_entity.dart';
import '../../domain/entities/wishlist_product_entity.dart';
import '../../domain/usecases/add_products_to_wishlist_usecase.dart';
import '../../domain/usecases/get_wishlist_usecase.dart';
import '../../domain/usecases/remove_products_from_wishlist_usecase.dart';

class WishlistController extends GetxController {
  final GetWishlistUseCase _getWishlistUseCase;
  final AddProductsToWishlistUseCase _addProductsToWishlistUseCase;
  final RemoveProductsFromWishlistUseCase _removeProductsFromWishlistUseCase;

  WishlistController({
    required GetWishlistUseCase getWishlistUseCase,
    required AddProductsToWishlistUseCase addProductsToWishlistUseCase,
    required RemoveProductsFromWishlistUseCase removeProductsFromWishlistUseCase,
  })  : _getWishlistUseCase = getWishlistUseCase,
        _addProductsToWishlistUseCase = addProductsToWishlistUseCase,
        _removeProductsFromWishlistUseCase = removeProductsFromWishlistUseCase;

  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;

  final Rxn<PaginatedWishlistProductListEntity> wishlist = Rxn<PaginatedWishlistProductListEntity>(null);
  final RxList<WishlistProductEntity> wishlistProducts = <WishlistProductEntity>[].obs;

  final ScrollController scrollController = ScrollController();

  final int pageLimit = 25;
  int currentOffset = 0;
  bool hasMoreData = true;

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading.value = true;

    await _getWishlist(
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

  Future<void> _getWishlist({
    required int offset,
    required int limit,
    required bool isLoadMore,
  }) async {
    if (isLoadMore) {
      isLoadingMore.value = true;
    }

    final result = await _getWishlistUseCase(
      GetWishlistParams(
        offset: offset,
        limit: limit,
      ),
    );

    result.fold(
      (failure) => Get.snackbar(failure.title, failure.message),
      (data) {
        wishlist.value = data;

        if (isLoadMore) {
          wishlistProducts.addAll(data.rows);
        } else {
          wishlistProducts.value = data.rows;
        }

        currentOffset = offset;
        hasMoreData = data.pagination.more && wishlistProducts.length < data.total;
      },
    );

    if (isLoadMore) {
      isLoadingMore.value = false;
    }
  }

  Future<void> refreshWishlist() async {
    currentOffset = 0;
    hasMoreData = true;
    await _getWishlist(
      offset: 0,
      limit: pageLimit,
      isLoadMore: false,
    );
  }

  Future<void> loadMore() async {
    if (isLoadingMore.value || !hasMoreData) return;

    final nextOffset = currentOffset + pageLimit;
    await _getWishlist(
      offset: nextOffset,
      limit: pageLimit,
      isLoadMore: true,
    );
  }

  Future<void> addToWishlist(int productId) async {
    final result = await _addProductsToWishlistUseCase(
      AddProductsToWishlistParams(productIds: [productId]),
    );

    result.fold(
      (failure) => Get.snackbar(failure.title, failure.message),
      (_) => Get.snackbar('Thành công', 'Thêm sản phẩm yêu thích thành công'),
    );
  }

  Future<void> removeFromWishlist(int productId) async {
    final result = await _removeProductsFromWishlistUseCase(
      RemoveProductsFromWishlistParams(productIds: [productId]),
    );

    result.fold(
      (failure) => Get.snackbar(failure.title, failure.message),
      (_) {
        wishlistProducts.removeWhere((e) => e.id == productId);
        Get.snackbar('Thành công', 'Xóa sản phẩm yêu thích thành công');
      },
    );
  }
}

