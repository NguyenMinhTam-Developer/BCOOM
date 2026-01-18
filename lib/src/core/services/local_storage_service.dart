import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalStorageService extends GetxService {
  late final GetStorage _storage;

  Future<LocalStorageService> init() async {
    await GetStorage.init();
    _storage = GetStorage();
    return this;
  }

  Future<void> saveData(String key, dynamic value) async {
    await _storage.write(key, value);
  }

  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  bool hasData(String key) {
    return _storage.hasData(key);
  }

  Future<void> clearAll() async {
    await _storage.erase();
  }

  void listenKey(String key, Function(dynamic) callback) {
    _storage.listenKey(key, callback);
  }
}
