import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/country_entity.dart';
import '../../domain/entities/location_list_entity.dart';
import '../../domain/entities/province_entity.dart';
import '../../domain/entities/ward_entity.dart';
import '../../domain/usecases/get_countries_usecase.dart';
import '../../domain/usecases/get_provinces_usecase.dart';
import '../../domain/usecases/get_wards_usecase.dart';

class LocationController extends GetxController {
  final GetCountriesUseCase _getCountriesUseCase;
  final GetProvincesUseCase _getProvincesUseCase;
  final GetWardsUseCase _getWardsUseCase;

  LocationController({
    required GetCountriesUseCase getCountriesUseCase,
    required GetProvincesUseCase getProvincesUseCase,
    required GetWardsUseCase getWardsUseCase,
  })  : _getCountriesUseCase = getCountriesUseCase,
        _getProvincesUseCase = getProvincesUseCase,
        _getWardsUseCase = getWardsUseCase;

  final RxBool isLoading = false.obs;
  final RxList<CountryEntity> countries = <CountryEntity>[].obs;
  final RxMap<ProvinceEntity, List<WardEntity>> provinceWardsMap = <ProvinceEntity, List<WardEntity>>{}.obs;

  // Helper getter to get provinces list
  List<ProvinceEntity> get provinces => provinceWardsMap.keys.toList();

  // Helper method to get wards for a specific province
  List<WardEntity>? getWardsForProvince(ProvinceEntity province) {
    return provinceWardsMap[province];
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadLocations();
  }

  Future<void> loadLocations() async {
    isLoading.value = true;

    try {
      // Call both countries and provinces in parallel
      final results = await Future.wait([
        _getCountriesUseCase(NoParams()),
        _getProvincesUseCase(NoParams()),
      ]) as List<Either<Failure, dynamic>>;

      // Handle countries result
      final countryResult = results[0] as Either<Failure, CountryListEntity>;
      countryResult.fold(
        (failure) => Get.snackbar(failure.title, failure.message),
        (countryList) => countries.value = countryList.countries,
      );

      // Handle provinces result
      final provinceResult = results[1] as Either<Failure, ProvinceListEntity>;
      provinceResult.fold(
        (failure) {
          Get.snackbar(failure.title, failure.message);
          isLoading.value = false;
        },
        (provinceList) {
          // After provinces finish, get wards for each province
          _loadWardsForProvinces(provinceList.provinces);
        },
      );
    } catch (e) {
      Get.snackbar('Lỗi', 'Đã có lỗi xảy ra khi tải dữ liệu địa điểm');
      isLoading.value = false;
    }
  }

  Future<void> _loadWardsForProvinces(List<ProvinceEntity> provinces) async {
    try {
      // Create a map to store the results
      final Map<ProvinceEntity, List<WardEntity>> tempMap = {};

      // Fetch wards for all provinces in parallel
      final wardResults = await Future.wait(
        provinces.map((province) => _getWardsUseCase(
              GetWardsParams(districtId: province.provinceCode),
            )),
      ) as List<Either<Failure, dynamic>>;

      // Map the results to provinces
      for (int i = 0; i < provinces.length; i++) {
        final province = provinces[i];
        final wardResult = wardResults[i] as Either<Failure, WardListEntity>;

        wardResult.fold(
          (failure) {
            // If failed, set empty list for this province
            tempMap[province] = [];
          },
          (wardList) {
            tempMap[province] = wardList.wards;
          },
        );
      }

      // Update the observable map
      provinceWardsMap.value = tempMap;
    } catch (e) {
      Get.snackbar('Lỗi', 'Đã có lỗi xảy ra khi tải danh sách phường/xã');
    } finally {
      isLoading.value = false;
    }
  }

  // Method to refresh locations data
  Future<void> refresh() async {
    await loadLocations();
  }
}
