import 'package:get/get.dart';

import '../../domain/entities/page_entity.dart';
import '../../domain/usecases/get_page_usecase.dart';

class PageViewController extends GetxController {
  final GetPageUseCase _getPageUseCase;

  PageViewController({
    required GetPageUseCase getPageUseCase,
  }) : _getPageUseCase = getPageUseCase;

  final RxBool isLoading = false.obs;
  final Rx<PageEntity?> page = Rx<PageEntity?>(null);

  @override
  void onInit() {
    super.onInit();
    final slug = Get.parameters['slug'];
    if (slug != null && slug.isNotEmpty) {
      loadPage(slug);
    }
  }

  Future<void> loadPage(String slug) async {
    isLoading.value = true;

    try {
      final result = await _getPageUseCase(GetPageParams(slug: slug));
      result.fold(
        (failure) {
          Get.snackbar(
            failure.title,
            failure.message,
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        (pageData) {
          page.value = pageData;
        },
      );
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Đã có lỗi xảy ra khi tải trang',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
