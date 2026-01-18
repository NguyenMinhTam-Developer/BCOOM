// ignore_for_file: avoid_print

import 'package:bcoom/src/core/routers/app_page_names.dart';
import 'package:bcoom/src/core/services/local_storage_service.dart';
import 'package:bcoom/src/features/auth/domain/entities/auth_response.dart';
import 'package:get/get.dart';
import 'package:logger/web.dart';

import '../../../features/auth/domain/entities/user.dart';
import '../../../features/auth/domain/repositories/auth_repository.dart';

class SessionService extends GetxService {
  final AuthRepository _authRepository;

  SessionService({required AuthRepository authRepository}) : _authRepository = authRepository;

  final Rx<UserEntity?> currentUser = Rx<UserEntity?>(null);

  static const String _tokenKey = 'auth_token';

  LocalStorageService get _prefs => Get.find<LocalStorageService>();

  /// Async initialization instead of onInit
  Future<SessionService> init() async {
    Logger().d("SessionService - init");
    String? localToken = _prefs.readData<String>(_tokenKey);

    if (localToken != null) {
      var getProfileResult = await _authRepository.getProfile();

      getProfileResult.fold(
        (failure) {
          print("USER NOT AUTHENTICATED - GET PROFILE FAILED");
        },
        (user) {
          print("USER AUTHENTICATED");
          currentUser.value = user;
        },
      );
    } else {
      print("USER NOT AUTHENTICATED - TOKEN NOT FOUND");
    }

    return this;
  }

  Future<void> clearSession() async {
    Logger().d("SessionService - clearSession");
    try {
      await _prefs.removeData(_tokenKey);
      currentUser.value = null;
    } catch (e) {
      print('Error clearing session: $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    Logger().d("SessionService - logout");
    await clearSession();
    Get.offAllNamed(AppPageNames.login);

    Get.snackbar(
      "Thông báo",
      "Đăng xuất thành công",
      snackPosition: SnackPosition.TOP,
    );
  }

  Future<void> updateSession(AuthResponse authResponse) async {
    Logger().d("SessionService - updateSession");
    await _prefs.saveData(_tokenKey, authResponse.data.token);
    currentUser.value = authResponse.data.user;
  }

  Future<void> updateSessionWithUser(UserEntity user) async {
    Logger().d("SessionService - updateSessionWithUser");
    currentUser.value = user;
  }

  Future<void> updateUser() async {
    Logger().d("SessionService - updateUser");
    var getProfileResult = await _authRepository.getProfile();

    getProfileResult.fold(
      (failure) {
        print("USER NOT AUTHENTICATED - GET PROFILE FAILED");
      },
      (user) {
        print("USER AUTHENTICATED");
        currentUser.value = user;
      },
    );
  }

  static SessionService get instance => Get.find<SessionService>();
}
