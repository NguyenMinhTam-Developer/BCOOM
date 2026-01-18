import 'package:get/get.dart';

import '../../domain/entities/faq_category_entity.dart';
import '../../domain/entities/faq_entity.dart';
import '../../domain/usecases/get_faqs_usecase.dart';

class FaqDetailController extends GetxController {
  final GetFaqsUseCase _getFaqsUseCase;

  FaqDetailController({
    required GetFaqsUseCase getFaqsUseCase,
  }) : _getFaqsUseCase = getFaqsUseCase;

  final RxBool isLoading = false.obs;
  final RxList<FaqEntity> faqs = <FaqEntity>[].obs;
  final Rx<int?> expandedItemId = Rx<int?>(null);
  late FaqCategoryEntity category;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null && arguments['category'] != null) {
      category = arguments['category'] as FaqCategoryEntity;
      loadFaqs();
    }
  }

  Future<void> loadFaqs() async {
    isLoading.value = true;

    try {
      final result = await _getFaqsUseCase(GetFaqsParams(categoryId: category.id));
      result.fold(
        (failure) {
          Get.snackbar(
            failure.title,
            failure.message,
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        (faqList) {
          faqs.value = faqList.rows;
        },
      );
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Đã có lỗi xảy ra khi tải danh sách câu hỏi',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void setExpandedItem(int? faqId) {
    expandedItemId.value = faqId;
  }

  bool isExpanded(int faqId) {
    return expandedItemId.value != null && expandedItemId.value == faqId;
  }
}
