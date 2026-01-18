import '../../routers/app_page_names.dart';
import 'session_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final sessionController = Get.find<SessionService>();

    // If not authenticated, redirect to login
    if (sessionController.currentUser.value == null) {
      return RouteSettings(name: AppPageNames.login);
    }

    // User is authenticated, proceed to requested route
    return null;
  }
}
