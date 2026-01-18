import '../../routers/app_page_names.dart';
import 'session_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../../routers/app_page_names.dart';
// import 'session_service.dart';

class SessionGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final sessionController = Get.find<SessionService>();

    // // If not authenticated, redirect to login
    if (sessionController.currentUser.value != null) {
      if (sessionController.currentUser.value?.emailVerifiedAt == null) {
        return RouteSettings(name: AppPageNames.accountVerification);
      }
    }
    // // If user is not verified, redirect to account verification
    // else if (sessionController.currentUser.value?.emailVerifiedAt == null) {
    //   return RouteSettings(name: AppPageNames.accountVerification);
    // }
    // If user is verified, but not completed profile, redirect to profile
    // else if (sessionController.currentUser.value?.emailVerifiedAt != null && sessionController.currentUser.value?.customerType == null) {
    //   return const RouteSettings(name: AppPageNames.profileCompletion);
    // }

    // User is authenticated, proceed to requested route
    return null;
  }
}
