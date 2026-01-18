import 'package:bcoom/src/core/di/tdd_binding.dart';
import 'package:get/get.dart';

import '../../../../core/network/authorized_client.dart';
import '../../data/datasources/address_remote_data_source.dart';
import '../../data/repositories/address_repository_impl.dart';
import '../../domain/repositories/address_repository.dart';
import '../../domain/usecases/create_address_usecase.dart';
import '../../domain/usecases/delete_address_usecase.dart';
import '../../domain/usecases/get_address_usecase.dart';
import '../../domain/usecases/get_addresses_usecase.dart';
import '../../domain/usecases/set_default_address_usecase.dart';
import '../../domain/usecases/update_address_usecase.dart';
import '../controllers/address_controller.dart';

class AddressBinding extends TddBinding {
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
    Get.lazyPut<GetAddressesUseCase>(
      () => GetAddressesUseCase(
        addressRepository: Get.find<AddressRepository>(),
      ),
    );

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

    Get.lazyPut<DeleteAddressUseCase>(
      () => DeleteAddressUseCase(
        addressRepository: Get.find<AddressRepository>(),
      ),
    );
  }

  @override
  void initController() {
    Get.put<AddressController>(
      AddressController(
        getAddressesUseCase: Get.find<GetAddressesUseCase>(),
        createAddressUseCase: Get.find<CreateAddressUseCase>(),
        updateAddressUseCase: Get.find<UpdateAddressUseCase>(),
        getAddressUseCase: Get.find<GetAddressUseCase>(),
        setDefaultAddressUseCase: Get.find<SetDefaultAddressUseCase>(),
        deleteAddressUseCase: Get.find<DeleteAddressUseCase>(),
      ),
    );
  }
}
