import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../domain/usecases/create_address_usecase.dart';
import '../../domain/usecases/set_default_address_usecase.dart';
import '../../../location/domain/entities/ward_entity.dart';
import '../../../location/presentation/controllers/location_controller.dart';

class CreateAddressController extends GetxController {
  final CreateAddressUseCase _createAddressUseCase;
  final SetDefaultAddressUseCase _setDefaultAddressUseCase;

  CreateAddressController({
    required CreateAddressUseCase createAddressUseCase,
    required SetDefaultAddressUseCase setDefaultAddressUseCase,
  })  : _createAddressUseCase = createAddressUseCase,
        _setDefaultAddressUseCase = setDefaultAddressUseCase;

  final formKey = GlobalKey<FormBuilderState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  final RxBool isLoading = false.obs;
  final Rxn<String> selectedProvinceCode = Rxn<String>(null);
  final Rxn<String> selectedWardCode = Rxn<String>(null);

  LocationController get locationController => Get.find<LocationController>();

  // Get available wards for selected province from LocationController
  List<WardEntity> get availableWards {
    if (selectedProvinceCode.value == null) return [];
    
    final province = locationController.provinces.firstWhereOrNull(
      (p) => p.provinceCode == selectedProvinceCode.value,
    );
    
    if (province == null) return [];
    
    return locationController.getWardsForProvince(province) ?? [];
  }

  Future<void> onProvinceChanged(String? provinceCode) async {
    selectedProvinceCode.value = provinceCode;
    selectedWardCode.value = null; // Reset ward when province changes
  }

  Future<void> onSubmit() async {
    if (!formKey.currentState!.validate()) {
      autoValidateMode = AutovalidateMode.onUserInteraction;
      return;
    }

    formKey.currentState!.save();
    final formData = formKey.currentState!.value;

    isLoading.value = true;

    // Create new address
    final isDefault = formData['is_default'] as bool? ?? false;

    // Get ward_code from form data or selected value
    final wardCodeFromForm = formData['ward_code'] as String?;
    final wardCode = wardCodeFromForm?.trim().isEmpty == true
        ? null
        : (wardCodeFromForm ?? selectedWardCode.value);

    // Get province_code from form data or selected value
    final provinceCodeFromForm = formData['province_code'] as String?;
    final provinceCode = provinceCodeFromForm?.trim().isEmpty == true
        ? null
        : (provinceCodeFromForm ?? selectedProvinceCode.value);

    final result = await _createAddressUseCase(
      CreateAddressParams(
        name: (formData['name'] as String).trim(),
        phone: (formData['phone'] as String).trim(),
        street: (formData['street'] as String).trim(),
        note: (formData['note'] as String?)?.trim().isEmpty == true
            ? null
            : (formData['note'] as String?)?.trim(),
        provinceCode: provinceCode?.isEmpty == true ? null : provinceCode,
        wardCode: wardCode?.isEmpty == true ? null : wardCode,
        isDefault: false, // Don't set as default in create, we'll call set-default endpoint separately
      ),
    );

    result.fold(
      (failure) {
        isLoading.value = false;
        Get.snackbar(failure.title, failure.message);
      },
      (entity) async {
        // Check if address should be set as default
        if (isDefault) {
          // Call set default address usecase
          final setDefaultResult = await _setDefaultAddressUseCase(
            SetDefaultAddressParams(id: entity.id),
          );
          setDefaultResult.fold(
            (failure) {
              // Don't show error if set default fails, just log it
              // The address was already created successfully
            },
            (_) {
              // Successfully set as default
            },
          );
        }

        isLoading.value = false;
        Get.back(result: true); // Return true to indicate success
        Get.snackbar('Thành công', 'Tạo địa chỉ thành công');
      },
    );
  }
}
