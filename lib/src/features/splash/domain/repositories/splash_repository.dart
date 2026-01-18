import '../entities/app_settings.dart';

abstract class SplashRepository {
  Future<AppSettings> getAppSettings();
  Future<void> setFirstLaunch(bool value);
}
