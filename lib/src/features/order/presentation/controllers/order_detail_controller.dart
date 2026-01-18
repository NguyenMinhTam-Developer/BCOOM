import 'package:get/get.dart';

import '../../domain/entities/order_detail_entity.dart';
import '../../domain/usecases/get_order_detail_usecase.dart';

class OrderDetailController extends GetxController {
  final GetOrderDetailUseCase _getOrderDetailUseCase;

  OrderDetailController({
    required GetOrderDetailUseCase getOrderDetailUseCase,
  }) : _getOrderDetailUseCase = getOrderDetailUseCase;

  final RxBool isLoading = false.obs;
  final Rx<OrderDetailEntity?> orderDetail = Rx<OrderDetailEntity?>(null);

  @override
  Future<void> onInit() async {
    super.onInit();
    final orderId = Get.parameters['id'];
    if (orderId != null) {
      await loadOrderDetail(int.parse(orderId));
    }
  }

  Future<void> loadOrderDetail(int orderId) async {
    isLoading.value = true;
    final result = await _getOrderDetailUseCase(
      GetOrderDetailParams(orderId: orderId),
    );
    result.fold(
      (failure) {
        Get.snackbar(
          failure.title,
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
        );
        orderDetail.value = null;
      },
      (detail) {
        orderDetail.value = detail;
      },
    );
    isLoading.value = false;
  }
}
