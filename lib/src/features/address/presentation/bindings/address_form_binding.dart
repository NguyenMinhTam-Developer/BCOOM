import 'package:bcoom/src/core/di/tdd_binding.dart';
import 'package:get/get.dart';

import '../../../../core/network/authorized_client.dart';
import '../../../location/presentation/bindings/location_binding.dart';
import '../../data/datasources/address_remote_data_source.dart';
import '../../data/repositories/address_repository_impl.dart';
import '../../domain/repositories/address_repository.dart';
import '../../domain/usecases/create_address_usecase.dart';
import '../../domain/usecases/get_address_usecase.dart';
import '../../domain/usecases/set_default_address_usecase.dart';
import '../../domain/usecases/update_address_usecase.dart';
import '../../../location/domain/repositories/location_repository.dart';
import '../../../location/domain/usecases/get_wards_usecase.dart';
import '../controllers/address_form_controller.dart';

class AddressFormBinding extends TddBinding {
  @override
  void initDataSource() {
    Get.lazyPut<AddressRemoteDataSource>(
      () => AddressRemoteDataSourceImpl(
        authorizedClient: Get.find<AuthorizedClient>(),
      ),
    );
  }

  @override
  void initRepository() {
    Get.lazyPut<AddressRepository>(
      () => AddressRepositoryImpl(
        Get.find<AddressRemoteDataSource>(),
      ),
    );
  }

  @override
  void initUseCase() {
    Get.lazyPut<CreateAddressUseCase>(
      () => CreateAddressUseCase(
        addressRepository: Get.find<AddressRepository>(),
      ),
    );

    Get.lazyPut<UpdateAddressUseCase>(
      () => UpdateAddressUseCase(
        addressRepository: Get.find<AddressRepository>(),
      ),
    );

    Get.lazyPut<GetAddressUseCase>(
      () => GetAddressUseCase(
        addressRepository: Get.find<AddressRepository>(),
      ),
    );

    Get.lazyPut<SetDefaultAddressUseCase>(
      () => SetDefaultAddressUseCase(
        addressRepository: Get.find<AddressRepository>(),
      ),
    );

    // Initialize location binding if not already initialized
    if (!Get.isRegistered<LocationRepository>()) {
      LocationBinding.init();
    }

    // Get wards use case
    Get.lazyPut<GetWardsUseCase>(
      () => GetWardsUseCase(
        locationRepository: Get.find<LocationRepository>(),
      ),
    );
  }

  @override
  void initController() {
    Get.put<AddressFormController>(
      AddressFormController(
        createAddressUseCase: Get.find<CreateAddressUseCase>(),
        updateAddressUseCase: Get.find<UpdateAddressUseCase>(),
        getAddressUseCase: Get.find<GetAddressUseCase>(),
        setDefaultAddressUseCase: Get.find<SetDefaultAddressUseCase>(),
        getWardsUseCase: Get.find<GetWardsUseCase>(),
      ),
    );
  }
}
