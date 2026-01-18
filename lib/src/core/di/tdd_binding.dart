import 'package:get/get.dart';

abstract class TddBinding implements Bindings {
  void initDataSource();
  void initRepository();
  void initUseCase();
  void initController();

  @override
  void dependencies() {
    // Initialize dependencies synchronously
    initDataSource();
    initRepository();
    initUseCase();
    initController();
  }
}
