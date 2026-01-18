import '../../domain/usecases/get_home_product_usecase.dart';
import 'package:get/get.dart';

class HomeProductController extends GetxController {
  final GetHomeProductUseCase _getHomeProductUseCase;
  final Rx<Map<String, dynamic>?> homeProduct = Rx<Map<String, dynamic>?>(null);
  final RxBool isLoading = false.obs;

  HomeProductController({
    required GetHomeProductUseCase getHomeProductUseCase,
  }) : _getHomeProductUseCase = getHomeProductUseCase;

  Future<void> getHomeProduct({required Map<String, dynamic> keywords}) async {
    isLoading.value = true;
    try {
      final result = await _getHomeProductUseCase(GetHomeProductParams(
        keywords: keywords,
      ));
      result.fold(
        (failure) {
          Get.snackbar(
            failure.title,
            failure.message,
            snackPosition: SnackPosition.TOP,
          );
        },
        (homeProductData) {
          homeProduct.value = homeProductData;
        },
      );
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Đã có lỗi xảy ra khi tải sản phẩm',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
