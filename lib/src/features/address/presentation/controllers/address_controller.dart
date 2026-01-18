import 'package:get/get.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/usecases/create_address_usecase.dart';
import '../../domain/usecases/delete_address_usecase.dart';
import '../../domain/usecases/get_address_usecase.dart';
import '../../domain/usecases/get_addresses_usecase.dart';
import '../../domain/usecases/set_default_address_usecase.dart';
import '../../domain/usecases/update_address_usecase.dart';

class AddressController extends GetxController {
  final GetAddressesUseCase _getAddressesUseCase;
  final CreateAddressUseCase _createAddressUseCase;
  final UpdateAddressUseCase _updateAddressUseCase;
  final GetAddressUseCase _getAddressUseCase;
  final SetDefaultAddressUseCase _setDefaultAddressUseCase;
  final DeleteAddressUseCase _deleteAddressUseCase;

  AddressController({
    required GetAddressesUseCase getAddressesUseCase,
    required CreateAddressUseCase createAddressUseCase,
    required UpdateAddressUseCase updateAddressUseCase,
    required GetAddressUseCase getAddressUseCase,
    required SetDefaultAddressUseCase setDefaultAddressUseCase,
    required DeleteAddressUseCase deleteAddressUseCase,
  })  : _getAddressesUseCase = getAddressesUseCase,
        _createAddressUseCase = createAddressUseCase,
        _updateAddressUseCase = updateAddressUseCase,
        _getAddressUseCase = getAddressUseCase,
        _setDefaultAddressUseCase = setDefaultAddressUseCase,
        _deleteAddressUseCase = deleteAddressUseCase;

  final RxBool isLoading = false.obs;
  final RxList<AddressEntity> addresses = <AddressEntity>[].obs;
  final Rx<AddressEntity?> selectedAddress = Rx<AddressEntity?>(null);

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadAddresses();
  }

  Future<void> loadAddresses() async {
    isLoading.value = true;
    final result = await _getAddressesUseCase(NoParams());
    result.fold(
      (failure) {
        Get.snackbar(
          failure.title,
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
        );
        // Clear addresses on error
        addresses.clear();
      },
      (entity) {
        addresses.value = entity.addresses;
        if (entity.addresses.isEmpty) {
          // Optionally show a message if list is empty
        }
      },
    );
    isLoading.value = false;
  }

  Future<void> createAddress({
    required String name,
    required String phone,
    required String street,
    String? note,
    String? wardCode,
    String? provinceCode,
    num? lat,
    num? lng,
    bool isDefault = false,
  }) async {
    isLoading.value = true;
    final result = await _createAddressUseCase(
      CreateAddressParams(
        name: name,
        phone: phone,
        street: street,
        note: note,
        wardCode: wardCode,
        provinceCode: provinceCode,
        lat: lat,
        lng: lng,
        isDefault: isDefault,
      ),
    );
    result.fold(
      (failure) => Get.snackbar(failure.title, failure.message),
      (entity) {
        addresses.add(entity);
        Get.snackbar('Thành công', 'Tạo địa chỉ thành công');
        loadAddresses(); // Reload to get updated list
      },
    );
    isLoading.value = false;
  }

  Future<void> updateAddress({
    required int id,
    String? name,
    String? phone,
    String? street,
    String? note,
    String? wardCode,
    String? provinceCode,
    num? lat,
    num? lng,
    bool? isDefault,
  }) async {
    isLoading.value = true;
    final result = await _updateAddressUseCase(
      UpdateAddressParams(
        id: id,
        name: name,
        phone: phone,
        street: street,
        note: note,
        wardCode: wardCode,
        provinceCode: provinceCode,
        lat: lat,
        lng: lng,
        isDefault: isDefault,
      ),
    );
    result.fold(
      (failure) => Get.snackbar(failure.title, failure.message),
      (entity) {
        final index = addresses.indexWhere((a) => a.id == id);
        if (index != -1) {
          addresses[index] = entity;
        }
        Get.snackbar('Thành công', 'Cập nhật địa chỉ thành công');
        loadAddresses(); // Reload to get updated list
      },
    );
    isLoading.value = false;
  }

  Future<void> getAddress(int id) async {
    isLoading.value = true;
    final result = await _getAddressUseCase(GetAddressParams(id: id));
    result.fold(
      (failure) => Get.snackbar(failure.title, failure.message),
      (entity) => selectedAddress.value = entity,
    );
    isLoading.value = false;
  }

  Future<void> setDefaultAddress(int id) async {
    isLoading.value = true;
    final result = await _setDefaultAddressUseCase(
      SetDefaultAddressParams(id: id),
    );
    result.fold(
      (failure) => Get.snackbar(failure.title, failure.message),
      (entity) {
        Get.snackbar('Thành công', 'Đặt địa chỉ mặc định thành công');
        loadAddresses(); // Reload to get updated list with correct isDefault values
      },
    );
    isLoading.value = false;
  }

  Future<void> deleteAddress(int id) async {
    isLoading.value = true;
    final result = await _deleteAddressUseCase(DeleteAddressParams(id: id));
    result.fold(
      (failure) => Get.snackbar(failure.title, failure.message),
      (_) {
        addresses.removeWhere((a) => a.id == id);
        Get.snackbar('Thành công', 'Xóa địa chỉ thành công');
      },
    );
    isLoading.value = false;
  }
}
