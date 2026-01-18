import 'package:get/get.dart';

import '../../../../core/network/unauthorized_client.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../data/datasources/location_local_data_source.dart';
import '../../data/datasources/location_remote_data_source.dart';
import '../../data/repositories/location_repository_impl.dart';
import '../../domain/repositories/location_repository.dart';
import '../../domain/usecases/get_countries_usecase.dart';
import '../../domain/usecases/get_provinces_usecase.dart';
import '../../domain/usecases/get_wards_usecase.dart';
import '../controllers/location_controller.dart';

class LocationBinding {
  static void init() {
    // Initialize local data source
    Get.lazyPut<LocationLocalDataSource>(
      () => LocationLocalDataSourceImpl(
        localStorageService: Get.find<LocalStorageService>(),
      ),
      fenix: true,
    );

    // Initialize remote data source
    Get.lazyPut<LocationRemoteDataSource>(
      () => LocationRemoteDataSourceImpl(
        unauthorizedClient: Get.find<UnauthorizedClient>(),
      ),
      fenix: true,
    );

    // Initialize repository
    Get.lazyPut<LocationRepository>(
      () => LocationRepositoryImpl(
        remoteDataSource: Get.find<LocationRemoteDataSource>(),
        localDataSource: Get.find<LocationLocalDataSource>(),
      ),
      fenix: true,
    );

    // Initialize use cases
    Get.lazyPut<GetCountriesUseCase>(
      () => GetCountriesUseCase(
        locationRepository: Get.find<LocationRepository>(),
      ),
      fenix: true,
    );

    Get.lazyPut<GetProvincesUseCase>(
      () => GetProvincesUseCase(
        locationRepository: Get.find<LocationRepository>(),
      ),
      fenix: true,
    );

    Get.lazyPut<GetWardsUseCase>(
      () => GetWardsUseCase(
        locationRepository: Get.find<LocationRepository>(),
      ),
      fenix: true,
    );

    // Initialize controller as permanent global instance
    Get.put<LocationController>(
      LocationController(
        getCountriesUseCase: Get.find<GetCountriesUseCase>(),
        getProvincesUseCase: Get.find<GetProvincesUseCase>(),
        getWardsUseCase: Get.find<GetWardsUseCase>(),
      ),
      permanent: true,
    );
  }
}
