import '../../../../core/services/local_storage_service.dart';

abstract class TokenLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> deleteToken();
}

class TokenLocalDataSourceImpl implements TokenLocalDataSource {
  final LocalStorageService localStorageService;
  static const String _tokenKey = 'auth_token';

  TokenLocalDataSourceImpl(this.localStorageService);

  @override
  Future<void> saveToken(String token) async {
    await localStorageService.saveData(_tokenKey, token);
  }

  @override
  Future<String?> getToken() async {
    return localStorageService.readData<String>(_tokenKey);
  }

  @override
  Future<void> deleteToken() async {
    await localStorageService.removeData(_tokenKey);
  }
}
