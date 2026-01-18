import 'package:get/get.dart';

class SalesController extends GetxController {
  final RxBool isLoading = false.obs;

  @override
  Future<void> refresh() async {
    isLoading.value = true;
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      // Reload data
    } catch (e) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }
}
