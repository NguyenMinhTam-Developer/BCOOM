import '../../../../core/services/local_storage_service.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository {
  final LocalStorageService _localStorageService;
  static const String _firstLaunchKey = 'is_first_launch';

  SplashRepositoryImpl(this._localStorageService);

  @override
  Future<AppSettings> getAppSettings() async {
    final isFirstLaunch = _localStorageService.readData<bool>(_firstLaunchKey) ?? true;
    return AppSettings(isFirstLaunch: isFirstLaunch);
  }

  @override
  Future<void> setFirstLaunch(bool value) async {
    await _localStorageService.saveData(_firstLaunchKey, value);
  }
}
