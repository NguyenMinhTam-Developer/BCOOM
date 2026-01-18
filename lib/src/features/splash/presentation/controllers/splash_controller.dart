import '../../../../core/routers/app_page_names.dart';
import 'package:get/get.dart';

// import '../../../../core/services/session/session_service.dart';
import '../../domain/usecases/check_first_launch.dart';

class SplashController extends GetxController {
  final CheckFirstLaunch _checkFirstLaunch;
  // final SessionService _sessionController = Get.find<SessionService>();

  final _isLoading = true.obs;
  final _isFirstLaunch = true.obs;

  SplashController({required CheckFirstLaunch checkFirstLaunch}) : _checkFirstLaunch = checkFirstLaunch;

  bool get isLoading => _isLoading.value;
  bool get isFirstLaunch => _isFirstLaunch.value;

  @override
  void onInit() {
    super.onInit();

    initialize();
  }

  Future<void> initialize() async {
    try {
      final appSettings = await _checkFirstLaunch();
      _isFirstLaunch.value = appSettings.isFirstLaunch;

      Future.delayed(const Duration(seconds: 3), () {
        _navigateToNextScreen();
      });
    } catch (e) {
      // Handle error appropriately
      printError(info: 'Error initializing splash: $e');
      _navigateToNextScreen();
    } finally {
      _isLoading.value = false;
    }
  }

  void _navigateToNextScreen() {
    if (_isFirstLaunch.value) {
      // First launch, go to onboarding
      AppPageNames.navigateToOnboarding();
    } else {
      AppPageNames.navigateToHome();
    }
  }
}
