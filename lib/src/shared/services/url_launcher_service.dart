import 'package:url_launcher/url_launcher.dart';

import '../helpers/notification_helper.dart';

class UrlLauncherService {
  static void onOpenEmailAppPressed() {
    try {
      final Uri emailLaunchUri = Uri(
        scheme: 'message',
      );

      launchUrl(emailLaunchUri);
    } catch (e) {
      NotificationHelper.showSnackBar(
        message: 'Could not open email app',
        type: NotificationType.error,
      );
    }
  }
}
