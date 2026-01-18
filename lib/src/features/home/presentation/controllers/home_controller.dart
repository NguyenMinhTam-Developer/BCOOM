import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/brand_list_entity.dart';
import '../../domain/entities/collection_list_entity.dart';
import '../../domain/usecases/get_brand_list_usecase.dart';
import '../../domain/usecases/get_collection_list_usecase.dart';
import '../../domain/usecases/get_landing_page_usecase.dart';
import '../../domain/usecases/get_raw_landing_page_usecase.dart';

class HomeController extends GetxController {
  final GetLandingPageUseCase _getLandingPageUseCase;
  final GetRawLandingPageUseCase _getRawLandingPageUseCase;
  final GetCollectionListUseCase _getCollectionListUseCase;
  final GetBrandListUseCase _getBrandListUseCase;

  final RxInt currentIndex = 0.obs;
  final RxBool isLoading = false.obs;
  final Rx<Map<String, dynamic>?> rawLandingPage = Rx<Map<String, dynamic>?>(null);
  final Rx<CollectionListEntity?> collectionList = Rx<CollectionListEntity?>(null);
  final Rx<BrandListEntity?> brandList = Rx<BrandListEntity?>(null);

  List<MapEntry<String, dynamic>> get elements {
    List<MapEntry<String, dynamic>> elements = rawLandingPage.value?.entries.toList() ?? [];
    // Order the elements by 'ordering' in value
    elements.sort((a, b) {
      final aOrder = (a.value is Map && a.value['ordering'] != null) ? a.value['ordering'] as int : 0;
      final bOrder = (b.value is Map && b.value['ordering'] != null) ? b.value['ordering'] as int : 0;
      return aOrder.compareTo(bOrder);
    });

    return elements;
  }

  List<MapEntry<String, dynamic>> get productElements {
    return elements.where((e) => e.value['home_position_type_key'] == 'product').toList();
  }

  HomeController({
    required GetLandingPageUseCase getLandingPageUseCase,
    required GetRawLandingPageUseCase getRawLandingPageUseCase,
    required GetCollectionListUseCase getCollectionListUseCase,
    required GetBrandListUseCase getBrandListUseCase,
  })  : _getLandingPageUseCase = getLandingPageUseCase,
        _getRawLandingPageUseCase = getRawLandingPageUseCase,
        _getCollectionListUseCase = getCollectionListUseCase,
        _getBrandListUseCase = getBrandListUseCase;

  @override
  void onInit() {
    super.onInit();
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    isLoading.value = true;
    try {
      // Call all use cases in parallel
      final results = await Future.wait([
        _getLandingPageUseCase(NoParams()),
        _getRawLandingPageUseCase(NoParams()),
        _getCollectionListUseCase(NoParams()),
      ]);
      final rawLandingPageResult = results[1] as Either<Failure, Map<String, dynamic>>;
      final collectionListResult = results[2] as Either<Failure, CollectionListEntity>;

      // Handle raw landing page result
      rawLandingPageResult.fold(
        (failure) {
          Get.snackbar(
            failure.title,
            failure.message,
            snackPosition: SnackPosition.TOP,
          );
        },
        (rawData) {
          rawLandingPage.value = rawData;
        },
      );

      // Handle collection list result
      collectionListResult.fold(
        (failure) {
          Get.snackbar(
            failure.title,
            failure.message,
            snackPosition: SnackPosition.TOP,
          );
        },
        (collectionData) {
          collectionList.value = collectionData;
        },
      );
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Đã có lỗi xảy ra khi tải dữ liệu',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getCollectionList() async {
    try {
      final result = await _getCollectionListUseCase(NoParams());
      result.fold(
        (failure) {
          Get.snackbar(
            failure.title,
            failure.message,
            snackPosition: SnackPosition.TOP,
          );
        },
        (collectionData) {
          collectionList.value = collectionData;
        },
      );
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Đã có lỗi xảy ra khi tải danh sách bộ sưu tập',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> getBrandList({
    num? categoryId,
    num? limit,
    num? offset,
    num? page,
    String? search,
    String? sort,
  }) async {
    try {
      final result = await _getBrandListUseCase(GetBrandListParams(
        categoryId: categoryId,
        limit: limit,
        offset: offset,
        page: page,
        search: search,
        sort: sort,
      ));
      result.fold(
        (failure) {
          Get.snackbar(
            failure.title,
            failure.message,
            snackPosition: SnackPosition.TOP,
          );
        },
        (brandData) {
          brandList.value = brandData;
        },
      );
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Đã có lỗi xảy ra khi tải danh sách thương hiệu',
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
