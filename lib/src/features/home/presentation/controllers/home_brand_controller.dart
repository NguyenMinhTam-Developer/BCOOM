import 'package:get/get.dart';

import '../../domain/entities/brand_list_entity.dart';
import '../../domain/usecases/get_brand_list_usecase.dart';

class HomeBrandController extends GetxController {
  final GetBrandListUseCase _getBrandListUseCase;
  final Rx<BrandListEntity?> brandList = Rx<BrandListEntity?>(null);
  final RxBool isLoading = false.obs;

  HomeBrandController({
    required GetBrandListUseCase getBrandListUseCase,
  }) : _getBrandListUseCase = getBrandListUseCase;

  Future<void> getBrandList({num? categoryId, num? limit, num? offset, num? page, String? search, String? sort}) async {
    isLoading.value = true;
    try {
      final result = await _getBrandListUseCase(GetBrandListParams(
        categoryId: categoryId,
        limit: limit,
        offset: offset,
        page: page,
        search: search,
        sort: sort,
      ));
      result.fold(
        (failure) {
          Get.snackbar(
            failure.title,
            failure.message,
            snackPosition: SnackPosition.TOP,
          );
        },
        (brandListData) {
          brandList.value = brandListData;
        },
      );
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Đã có lỗi xảy ra khi tải danh sách thương hiệu',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
