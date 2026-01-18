import 'package:bcoom/src/core/di/tdd_binding.dart';
import 'package:get/get.dart';

import '../../../../core/network/authorized_client.dart';
import '../../data/datasources/address_remote_data_source.dart';
import '../../data/repositories/address_repository_impl.dart';
import '../../domain/repositories/address_repository.dart';
import '../../domain/usecases/create_address_usecase.dart';
import '../../domain/usecases/set_default_address_usecase.dart';
import '../controllers/create_address_controller.dart';

class CreateAddressBinding extends TddBinding {
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

    Get.lazyPut<SetDefaultAddressUseCase>(
      () => SetDefaultAddressUseCase(
        addressRepository: Get.find<AddressRepository>(),
      ),
    );
  }

  @override
  void initController() {
    Get.put<CreateAddressController>(
      CreateAddressController(
        createAddressUseCase: Get.find<CreateAddressUseCase>(),
        setDefaultAddressUseCase: Get.find<SetDefaultAddressUseCase>(),
      ),
    );
  }
}
