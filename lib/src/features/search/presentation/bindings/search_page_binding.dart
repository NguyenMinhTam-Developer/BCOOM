import 'package:bcoom/src/core/di/tdd_binding.dart';
import 'package:get/get.dart';

import '../../../../core/network/authorized_client.dart';
import '../../../../core/network/unauthorized_client.dart';
import '../../../home/data/source/home_remote_data_source.dart';
import '../../../home/domain/usecases/get_collection_list_usecase.dart';
import '../../data/repositories/search_repository_impl.dart';
import '../../data/source/search_remote_data_source.dart';
import '../../domain/repositories/search_repository.dart';
import '../../domain/usecases/get_my_keywords_usecase.dart';
import '../../domain/usecases/get_suggestion_keywords_usecase.dart';
import '../../domain/usecases/search_usecase.dart';
import '../controllers/search_controller.dart';

class SearchPageBinding extends TddBinding {
  @override
  void initDataSource() {
    Get.lazyPut<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(
        unauthorizedClient: Get.find<UnauthorizedClient>(),
      ),
    );

    Get.lazyPut<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl(
        authorizedClient: Get.find<AuthorizedClient>(),
      ),
    );
  }

  @override
  void initRepository() {
    Get.lazyPut<SearchRepository>(
      () => SearchRepositoryImpl(
        Get.find<SearchRemoteDataSource>(),
      ),
    );
  }

  @override
  void initUseCase() {
    Get.lazyPut<GetMyKeywordsUseCase>(
      () => GetMyKeywordsUseCase(
        searchRepository: Get.find<SearchRepository>(),
      ),
    );

    Get.lazyPut<GetSuggestionKeywordsUseCase>(
      () => GetSuggestionKeywordsUseCase(
        searchRepository: Get.find<SearchRepository>(),
      ),
    );

    Get.lazyPut<SearchUseCase>(
      () => SearchUseCase(
        searchRepository: Get.find<SearchRepository>(),
      ),
    );
  }

  @override
  void initController() {
    Get.lazyPut<CatalogSearchController>(
      () => CatalogSearchController(
        getMyKeywordsUseCase: Get.find<GetMyKeywordsUseCase>(),
        getSuggestionKeywordsUseCase: Get.find<GetSuggestionKeywordsUseCase>(),
        searchUseCase: Get.find<SearchUseCase>(),
        getCollectionListUseCase: Get.find<GetCollectionListUseCase>(),
      ),
    );
  }
}
