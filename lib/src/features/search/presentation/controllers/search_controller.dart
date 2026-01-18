import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../home/domain/usecases/get_collection_list_usecase.dart';
import '../../../home/presentation/controllers/home_controller.dart';
import '../../domain/entities/my_keyword_entity.dart';
import '../../domain/entities/search_product_entity.dart';
import '../../domain/entities/search_result_entity.dart';
import '../../domain/entities/suggestion_keyword_list_entity.dart';
import '../../domain/usecases/get_my_keywords_usecase.dart';
import '../../domain/usecases/get_suggestion_keywords_usecase.dart';
import '../../domain/usecases/search_usecase.dart';

class CatalogSearchController extends GetxController {
  final GetMyKeywordsUseCase _getMyKeywordsUseCase;
  final GetSuggestionKeywordsUseCase _getSuggestionKeywordsUseCase;
  final SearchUseCase _searchUseCase;
  final GetCollectionListUseCase _getCollectionListUseCase;

  final RxBool isLoading = false.obs;

  /// Whether a search has been submitted
  final RxBool hasSearched = false.obs;

  /// The submitted search query (only set when search is performed)
  final RxString submittedQuery = ''.obs;

  /// Search results
  final RxList<SearchProductEntity> searchResults = <SearchProductEntity>[].obs;

  /// Search history
  final RxList<String> searchHistory = <String>[].obs;

  /// My keywords
  final RxList<MyKeywordEntity> myKeywords = <MyKeywordEntity>[].obs;

  /// Suggestion keywords
  final Rx<SuggestionKeywordListEntity?> suggestionKeywords = Rx<SuggestionKeywordListEntity?>(null);

  /// Search results from API
  final Rx<SearchResultEntity?> searchResult = Rx<SearchResultEntity?>(null);

  /// Selected collection index for top collections
  final RxInt selectedCollectionIndex = 0.obs;

  CatalogSearchController({
    required GetMyKeywordsUseCase getMyKeywordsUseCase,
    required GetSuggestionKeywordsUseCase getSuggestionKeywordsUseCase,
    required SearchUseCase searchUseCase,
    required GetCollectionListUseCase getCollectionListUseCase,
  })  : _getMyKeywordsUseCase = getMyKeywordsUseCase,
        _getSuggestionKeywordsUseCase = getSuggestionKeywordsUseCase,
        _searchUseCase = searchUseCase,
        _getCollectionListUseCase = getCollectionListUseCase;

  /// Text editing controller for search input
  late final TextEditingController searchTextController;

  /// Focus node for search input
  late final FocusNode searchFocusNode;

  @override
  void onInit() {
    super.onInit();
    searchTextController = TextEditingController();
    searchFocusNode = FocusNode();

    // Auto focus on search field when page opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchFocusNode.requestFocus();
    });

    // Load my keywords and suggestion keywords on init
    getMyKeywords();
    getSuggestionKeywords(search: '', offset: 0, limit: 20);
  }

  @override
  void onClose() {
    searchTextController.dispose();
    searchFocusNode.dispose();
    super.onClose();
  }

  /// Perform search
  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      searchResults.clear();
      hasSearched.value = false;
      return;
    }

    submittedQuery.value = query;
    hasSearched.value = true;
    isLoading.value = true;

    try {
      // Add to search history if not already present
      if (!searchHistory.contains(query)) {
        searchHistory.insert(0, query);
        // Keep only last 10 searches
        if (searchHistory.length > 10) {
          searchHistory.removeLast();
        }
      }

      // Get first collection slug from HomeController
      String collectionSlug = '';
      try {
        final homeController = Get.find<HomeController>();
        final collections = homeController.collectionList.value?.rows ?? [];
        if (collections.isNotEmpty) {
          collectionSlug = collections[0].slug;
          // Set selected collection index to first collection
          selectedCollectionIndex.value = 0;
        }
      } catch (e) {
        // HomeController not available, use empty string
        collectionSlug = '';
      }

      // Use SearchUseCase to search products with first collection slug
      await searchProducts(
        collectionSlug: collectionSlug,
        search: query,
        offset: 0,
        limit: 20,
      );
    } catch (e) {
      // Handle error
      Get.snackbar(
        'Lỗi',
        'Đã có lỗi xảy ra khi tìm kiếm',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Clear search
  void clearSearch() {
    searchTextController.clear();
    submittedQuery.value = '';
    hasSearched.value = false;
    searchResults.clear();
    searchResult.value = null;
  }

  /// Remove item from search history
  void removeFromHistory(String query) {
    searchHistory.remove(query);
  }

  /// Clear all search history
  void clearHistory() {
    searchHistory.clear();
  }

  /// Clear my keywords
  void clearMyKeywords() {
    myKeywords.clear();
  }

  /// Select from history
  void selectFromHistory(String query) {
    searchTextController.text = query;
    search(query);
  }

  /// Get my keywords
  Future<void> getMyKeywords() async {
    // Don't set loading for my keywords to avoid blocking UI
    try {
      final result = await _getMyKeywordsUseCase(NoParams());
      result.fold(
        (failure) {
          // Silently fail for my keywords - don't show error to user
        },
        (keywords) {
          myKeywords.value = keywords;
        },
      );
    } catch (e) {
      // Silently fail for my keywords
    }
  }

  /// Get suggestion keywords
  Future<void> getSuggestionKeywords({
    required String search,
    required int offset,
    required int limit,
  }) async {
    // Don't set loading for suggestion keywords to avoid blocking UI
    try {
      final result = await _getSuggestionKeywordsUseCase(
        GetSuggestionKeywordsParams(
          search: search,
          offset: offset,
          limit: limit,
        ),
      );
      result.fold(
        (failure) {
          // Silently fail for suggestions - don't show error to user
        },
        (suggestions) {
          suggestionKeywords.value = suggestions;
        },
      );
    } catch (e) {
      // Silently fail for suggestions
    }
  }

  /// Search products
  Future<void> searchProducts({
    required String collectionSlug,
    required String search,
    int? offset,
    int? limit,
    String? sort,
    String? order,
  }) async {
    isLoading.value = true;
    try {
      final result = await _searchUseCase(
        SearchParams(
          collectionSlug: collectionSlug,
          search: search,
          offset: offset,
          limit: limit,
          sort: sort,
          order: order,
        ),
      );
      result.fold(
        (failure) {
          Get.snackbar(
            failure.title,
            failure.message,
            snackPosition: SnackPosition.TOP,
          );
        },
        (result) {
          searchResult.value = result;
          // Update searchResults list for compatibility
          searchResults.value = result.rows;
          // Mark as searched when results are loaded
          if (result.rows.isNotEmpty) {
            hasSearched.value = true;
          }
        },
      );
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        'Đã có lỗi xảy ra khi tìm kiếm',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
