import 'package:dartz/dartz.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/errors/failures.dart';

class UrlLauncherService {
  static Future<Either<Failure, void>> launchHttps({required String url}) async {
    final Uri uri = Uri.parse(url);

    if (!await canLaunchUrl(uri)) {
      return Left(UnknownFailure(title: 'Lỗi', message: 'Không thể mở trang web: $uri'));
    }

    launchUrl(uri, mode: LaunchMode.externalApplication);

    return Right(null);
  }
}
