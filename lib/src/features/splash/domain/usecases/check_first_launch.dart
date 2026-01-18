import '../entities/app_settings.dart';
import '../repositories/splash_repository.dart';

class CheckFirstLaunch {
  final SplashRepository repository;

  CheckFirstLaunch(this.repository);

  Future<AppSettings> call() async {
    var appSettings = await repository.getAppSettings();

    if (appSettings.isFirstLaunch) {
      await repository.setFirstLaunch(false);
    }

    return appSettings;
  }
}
