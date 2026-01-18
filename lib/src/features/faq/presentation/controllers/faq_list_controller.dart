import 'package:get/get.dart';

import '../../../../core/routers/app_page_names.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/faq_category_entity.dart';
import '../../domain/usecases/get_faq_categories_usecase.dart';

class FaqListController extends GetxController {
  final GetFaqCategoriesUseCase _getFaqCategoriesUseCase;

  FaqListController({
    required GetFaqCategoriesUseCase getFaqCategoriesUseCase,
  }) : _getFaqCategoriesUseCase = getFaqCategoriesUseCase;

  final RxBool isLoading = false.obs;
  final RxList<FaqCategoryEntity> categories = <FaqCategoryEntity>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadCategories();
  }

  Future<void> loadCategories() async {
    isLoading.value = true;

    try {
      final result = await _getFaqCategoriesUseCase(NoParams());
      result.fold(
        (failure) {
          Get.snackbar(
            failure.title,
            failure.message,
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        (categoryList) {
          categories.value = categoryList.rows;
        },
      );
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Đã có lỗi xảy ra khi tải danh sách FAQ',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void onCategoryTap(FaqCategoryEntity category) {
    Get.toNamed(AppPageNames.faqDetail, arguments: {'category': category});
  }
}
