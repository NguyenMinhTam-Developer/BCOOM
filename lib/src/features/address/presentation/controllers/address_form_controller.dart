import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

import '../../domain/entities/address_entity.dart';
import '../../domain/usecases/create_address_usecase.dart';
import '../../domain/usecases/get_address_usecase.dart';
import '../../domain/usecases/set_default_address_usecase.dart';
import '../../domain/usecases/update_address_usecase.dart';
import '../../../location/domain/entities/ward_entity.dart';
import '../../../location/domain/usecases/get_wards_usecase.dart';

class AddressFormController extends GetxController {
  final CreateAddressUseCase _createAddressUseCase;
  final UpdateAddressUseCase _updateAddressUseCase;
  final GetAddressUseCase _getAddressUseCase;
  final SetDefaultAddressUseCase _setDefaultAddressUseCase;
  final GetWardsUseCase _getWardsUseCase;

  AddressFormController({
    required CreateAddressUseCase createAddressUseCase,
    required UpdateAddressUseCase updateAddressUseCase,
    required GetAddressUseCase getAddressUseCase,
    required SetDefaultAddressUseCase setDefaultAddressUseCase,
    required GetWardsUseCase getWardsUseCase,
  })  : _createAddressUseCase = createAddressUseCase,
        _updateAddressUseCase = updateAddressUseCase,
        _getAddressUseCase = getAddressUseCase,
        _setDefaultAddressUseCase = setDefaultAddressUseCase,
        _getWardsUseCase = getWardsUseCase;

  final formKey = GlobalKey<FormBuilderState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  
  // Helper method to get form state
  FormBuilderState? get formState => formKey.currentState;

  final RxBool isLoading = false.obs;
  final RxBool isLoadingWards = false.obs;
  final RxList<WardEntity> availableWards = <WardEntity>[].obs;
  final Rxn<String> selectedProvinceCode = Rxn<String>(null);
  final Rxn<String> selectedWardCode = Rxn<String>(null);

  AddressEntity? _editingAddress;
  bool get isEditMode => _editingAddress != null;
  AddressEntity? get editingAddress => _editingAddress;

  @override
  Future<void> onInit() async {
    super.onInit();
    
    // Check if we're editing an existing address
    final addressId = Get.parameters['id'];
    if (addressId != null) {
      await _loadAddressForEdit(int.parse(addressId));
    }
  }

  Future<void> _loadAddressForEdit(int addressId) async {
    isLoading.value = true;
    final result = await _getAddressUseCase(GetAddressParams(id: addressId));
    result.fold(
      (failure) {
        Get.snackbar(failure.title, failure.message);
        Get.back();
        isLoading.value = false;
      },
      (address) async {
        _editingAddress = address;
        selectedProvinceCode.value = address.province?.provinceCode;
        selectedWardCode.value = address.ward?.wardCode;
        
        // Load wards for the selected province first
        if (selectedProvinceCode.value != null) {
          await _loadWardsForProvince(selectedProvinceCode.value!);
        }
        
        // Update form fields with loaded address data after wards are loaded
        // Use multiple attempts to ensure form is built
        int attempts = 0;
        while (attempts < 10 && formKey.currentState == null) {
          await Future.delayed(const Duration(milliseconds: 50));
          attempts++;
        }
        
        if (formKey.currentState != null) {
          formKey.currentState!.patchValue({
            'name': address.name ?? '',
            'phone': address.phone ?? '',
            'street': address.street ?? '',
            'note': address.note ?? '',
            'address_type': 'home', // Default, can be updated if API provides this
            'is_default': address.isDefault,
            'province_code': selectedProvinceCode.value ?? address.province?.provinceCode,
            'ward_code': selectedWardCode.value ?? address.ward?.wardCode,
          });
        }
        
        isLoading.value = false;
      },
    );
  }

  Future<void> onProvinceChanged(String? provinceCode) async {
    selectedProvinceCode.value = provinceCode;
    selectedWardCode.value = null; // Reset ward when province changes
    availableWards.clear();
    
    if (provinceCode != null) {
      await _loadWardsForProvince(provinceCode);
    }
  }

  Future<void> _loadWardsForProvince(String provinceCode) async {
    isLoadingWards.value = true;
    final result = await _getWardsUseCase(GetWardsParams(districtId: provinceCode));
    result.fold(
      (failure) {
        Get.snackbar(failure.title, failure.message);
        availableWards.clear();
      },
      (wardList) {
        availableWards.value = wardList.wards;
      },
    );
    isLoadingWards.value = false;
  }

  Future<void> onSubmit() async {
    if (!formKey.currentState!.validate()) {
      autoValidateMode = AutovalidateMode.onUserInteraction;
      return;
    }

    formKey.currentState!.save();
    final formData = formKey.currentState!.value;

    isLoading.value = true;

    if (isEditMode && _editingAddress != null) {
      // Update existing address
      // Use form data if provided, otherwise use original address data
      final address = _editingAddress!;
      
      // Get ward_code: prefer form data, then selected value, then original address value
      final wardCodeFromForm = formData['ward_code'] as String?;
      final wardCode = wardCodeFromForm?.trim().isEmpty == true 
          ? null 
          : (wardCodeFromForm ?? selectedWardCode.value ?? address.ward?.wardCode);
      
      // Get province_code: prefer form data, then selected value, then original address value
      final provinceCodeFromForm = formData['province_code'] as String?;
      final provinceCode = provinceCodeFromForm?.trim().isEmpty == true 
          ? null 
          : (provinceCodeFromForm ?? selectedProvinceCode.value ?? address.province?.provinceCode);
      
      final result = await _updateAddressUseCase(
        UpdateAddressParams(
          id: address.id,
          // Use form data if provided and not empty, otherwise use original address data
          name: (formData['name'] as String?)?.trim().isEmpty == true 
              ? null 
              : ((formData['name'] as String?)?.trim() ?? address.name),
          phone: (formData['phone'] as String?)?.trim().isEmpty == true 
              ? null 
              : ((formData['phone'] as String?)?.trim() ?? address.phone),
          street: (formData['street'] as String?)?.trim().isEmpty == true 
              ? null 
              : ((formData['street'] as String?)?.trim() ?? address.street),
          note: (formData['note'] as String?)?.trim().isEmpty == true 
              ? null 
              : ((formData['note'] as String?)?.trim() ?? address.note),
          provinceCode: provinceCode?.isEmpty == true ? null : provinceCode,
          wardCode: wardCode?.isEmpty == true ? null : wardCode,
        ),
      );

      result.fold(
        (failure) {
          isLoading.value = false;
          Get.snackbar(failure.title, failure.message);
        },
        (entity) async {
          // Check if address should be set as default
          final isDefault = formData['is_default'] as bool? ?? false;
          if (isDefault) {
            // Call set default address usecase
            final setDefaultResult = await _setDefaultAddressUseCase(
              SetDefaultAddressParams(id: entity.id),
            );
            setDefaultResult.fold(
              (failure) {
                // Don't show error if set default fails, just log it
                // The address was already updated successfully
              },
              (_) {
                // Successfully set as default
              },
            );
          }
          
          isLoading.value = false;
          Get.back(result: true); // Return true to indicate success
          Get.snackbar('Thành công', 'Cập nhật địa chỉ thành công');
        },
      );
    } else {
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
          note: (formData['note'] as String?)?.trim().isEmpty == true ? null : (formData['note'] as String?)?.trim(),
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
}
