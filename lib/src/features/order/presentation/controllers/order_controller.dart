import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/usecases/get_order_list_usecase.dart';
import '../../domain/usecases/get_order_status_usecase.dart';

class OrderController extends GetxController {
  final GetOrderStatusUseCase _getOrderStatusUseCase;
  final GetOrderListUseCase _getOrderListUseCase;

  OrderController({
    required GetOrderStatusUseCase getOrderStatusUseCase,
    required GetOrderListUseCase getOrderListUseCase,
  })  : _getOrderStatusUseCase = getOrderStatusUseCase,
        _getOrderListUseCase = getOrderListUseCase;

  final RxBool isLoading = false.obs;
  final RxBool isLoadingOrders = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxList<OrderStatus> orderStatusList = <OrderStatus>[].obs;
  final RxInt selectedTabIndex = 0.obs;

  // Cache for each status
  final Map<String, List<OrderEntity>> _cachedOrders = {};
  final Map<String, int> _cachedOffsets = {};
  final Map<String, bool> _cachedHasMore = {};
  final Map<String, int> _cachedTotals = {};

  final ScrollController scrollController = ScrollController();
  final int pageLimit = 10;

  // Get current orders list based on selected tab
  List<OrderEntity> get currentOrdersList {
    if (orderStatusList.isEmpty) return [];
    final statusCode = _getCurrentStatusCode();
    return _cachedOrders[statusCode] ?? [];
  }

  // Get current loading more state
  bool get currentHasMore {
    if (orderStatusList.isEmpty) return false;
    final statusCode = _getCurrentStatusCode();
    return _cachedHasMore[statusCode] ?? false;
  }

  String _getCurrentStatusCode() {
    if (orderStatusList.isEmpty) return '';
    return orderStatusList[selectedTabIndex.value].code;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadOrderStatus();
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

  Future<void> loadOrderStatus() async {
    isLoading.value = true;
    final result = await _getOrderStatusUseCase(NoParams());
    result.fold(
      (failure) {
        Get.snackbar(
          failure.title,
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
        );
        orderStatusList.clear();
        isLoading.value = false;
      },
      (statusList) async {
        orderStatusList.value = statusList;
        // Load first status orders after status list is loaded
        if (statusList.isNotEmpty) {
          await loadOrderList(statusCode: statusList.first.code, isLoadMore: false);
        }
        isLoading.value = false;
      },
    );
  }

  Future<void> loadOrderList({
    required String statusCode,
    required bool isLoadMore,
  }) async {
    // Check if data is already cached (only skip if we have data, not if it's empty)
    if (!isLoadMore && _cachedOrders.containsKey(statusCode)) {
      // Data already exists (even if empty), don't fetch again
      return;
    }

    if (isLoadMore) {
      isLoadingMore.value = true;
    } else {
      isLoadingOrders.value = true;
    }

    final offset = isLoadMore ? (_cachedOffsets[statusCode] ?? 0) : 0;

    final result = await _getOrderListUseCase(
      GetOrderListParams(
        offset: offset,
        limit: pageLimit,
        statusCode: statusCode == 'total' ? null : statusCode,
      ),
    );

    result.fold(
      (failure) {
        Get.snackbar(
          failure.title,
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      (orderList) {
        if (isLoadMore) {
          // Append new orders to existing list
          final existingOrders = _cachedOrders[statusCode] ?? [];
          _cachedOrders[statusCode] = [...existingOrders, ...orderList.rows];
        } else {
          // Replace with new orders
          _cachedOrders[statusCode] = orderList.rows;
        }

        // Update pagination state
        _cachedOffsets[statusCode] = offset + orderList.rows.length;
        _cachedTotals[statusCode] = orderList.total;
        _cachedHasMore[statusCode] = _cachedOrders[statusCode]!.length < orderList.total;
      },
    );

    if (isLoadMore) {
      isLoadingMore.value = false;
    } else {
      isLoadingOrders.value = false;
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore.value || !currentHasMore || orderStatusList.isEmpty) return;

    final statusCode = _getCurrentStatusCode();
    await loadOrderList(statusCode: statusCode, isLoadMore: true);
  }

  void onTabTap(int index) async {
    if (index == selectedTabIndex.value) return;

    selectedTabIndex.value = index;
    final statusCode = orderStatusList[index].code;

    // Reset scroll position
    if (scrollController.hasClients) {
      scrollController.jumpTo(0);
    }

    // Always refresh data when switching tabs (clear cache and reload)
    _cachedOrders.remove(statusCode);
    _cachedOffsets.remove(statusCode);
    _cachedHasMore.remove(statusCode);
    _cachedTotals.remove(statusCode);
    
    await loadOrderList(statusCode: statusCode, isLoadMore: false);
  }

  Future<void> refresh() async {
    final statusCode = _getCurrentStatusCode();
    
    // Reset scroll position
    if (scrollController.hasClients) {
      scrollController.jumpTo(0);
    }
    
    // Clear cache for current status
    _cachedOrders.remove(statusCode);
    _cachedOffsets.remove(statusCode);
    _cachedHasMore.remove(statusCode);
    _cachedTotals.remove(statusCode);
    
    // Reload data
    await loadOrderList(statusCode: statusCode, isLoadMore: false);
  }
}
