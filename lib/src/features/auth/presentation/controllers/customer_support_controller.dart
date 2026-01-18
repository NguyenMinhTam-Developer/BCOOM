import 'package:get/get.dart';

import '../../../faq/domain/entities/faq_entity.dart';
import '../../../faq/domain/usecases/get_all_faqs_usecase.dart';
import '../../../../core/usecases/usecase.dart';

class CustomerSupportController extends GetxController {
  final GetAllFaqsUseCase _getAllFaqsUseCase;

  CustomerSupportController({
    required GetAllFaqsUseCase getAllFaqsUseCase,
  }) : _getAllFaqsUseCase = getAllFaqsUseCase;

  final RxBool isLoading = false.obs;
  final RxList<FaqEntity> faqs = <FaqEntity>[].obs;
  final Rx<int?> expandedItemId = Rx<int?>(null);

  @override
  void onInit() {
    super.onInit();
    loadFaqs();
  }

  Future<void> loadFaqs() async {
    isLoading.value = true;

    try {
      final result = await _getAllFaqsUseCase(NoParams());
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
