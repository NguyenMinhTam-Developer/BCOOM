import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum NotificationType { brand, gray, error, warning, success }

class NotificationHelper {
  static showSnackBar({
    String? title = "Alert",
    required String message,
    bool indefiniteDuration = false,
    bool showProgressIndicator = false,
    SnackStyle snackStyle = SnackStyle.FLOATING,
    SnackPosition snackPosition = SnackPosition.TOP,
    required NotificationType type,
  }) {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }

    IconData icon = Symbols.info_i_rounded;
    Color iconColor = Colors.grey[800]!;

    switch (type) {
      case NotificationType.brand:
        icon = Symbols.info_i_rounded;
        iconColor = Colors.blueAccent;
        break;
      case NotificationType.gray:
        icon = Symbols.info_i_rounded;
        iconColor = Colors.grey;
        break;
      case NotificationType.error:
        icon = Symbols.info_i_rounded;
        iconColor = Colors.redAccent;
        break;
      case NotificationType.warning:
        icon = Symbols.info_i_rounded;
        iconColor = Colors.orangeAccent;
        break;
      case NotificationType.success:
        icon = Symbols.check_circle_rounded;
        iconColor = Colors.green;
        break;
    }

    Get.showSnackbar(GetSnackBar(
      icon: Icon(icon, color: iconColor, fill: 0),
      shouldIconPulse: true,
      titleText: title != null
          ? Text(
              title,
              style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
            )
          : null,
      messageText: Text(
        message,
        style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.normal),
      ),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: indefiniteDuration ? null : const Duration(seconds: 5),
      snackStyle: snackStyle,
      snackPosition: snackPosition,
      showProgressIndicator: showProgressIndicator,
      backgroundColor: Colors.grey[100]!,
      borderColor: Colors.grey[200]!,
      borderWidth: 1,
    ));
  }

  static closeSnackBar() {
    Get.closeCurrentSnackbar();
  }
}
