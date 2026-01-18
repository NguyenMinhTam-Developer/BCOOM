import 'package:bcoom/src/features/catalog/presentation/pages/product_list_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../core/routers/app_page_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/components/buttons.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../../../catalog/presentation/controllers/catalog_controller.dart';
import '../../../home/presentation/controllers/home_controller.dart';
import '../../../home/presentation/widgets/home_product_widget.dart';
import '../controllers/search_controller.dart';
import '../widgets/search_product_widget.dart';
import '../../../catalog/presentation/widgets/filter_bottom_sheet.dart';

class SearchPage extends GetView<CatalogSearchController> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Symbols.clear_rounded, color: AppColors.text500),
        ),
        title: _buildSearchField(),
        titleSpacing: 0,
        actions: [
          SizedBox(width: 16.w),
          AppIconButton(
            onPressed: () {},
            icon: Assets.svgs.icons.shoppingCart.svg(),
          ),
          SizedBox(width: 16.w),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Divider(
            color: AppColors.bg400,
            height: 1.h,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!controller.hasSearched.value) {
          return _buildEmptyQueries();
        }

        if (controller.searchResult.value == null || controller.searchResult.value!.rows.isEmpty) {
          return _buildEmptyResults();
        }

        return _buildSearchResults();
      }),
    );
  }

  Widget _buildSearchField() {
    return FormBuilderTextField(
      name: 'search',
      controller: controller.searchTextController,
      decoration: InputDecoration(
        hintText: 'Tìm gì mời gõ vào đây',
        isDense: true,
        contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        suffixIconConstraints: BoxConstraints(minWidth: 44.w, minHeight: 20.h),
        suffixIcon: ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller.searchTextController,
          builder: (context, value, child) {
            final isEmpty = value.text.isEmpty;
            return GestureDetector(
              onTap: () {
                if (!isEmpty) {
                  controller.searchTextController.clear();
                }
              },
              child: isEmpty
                  ? Assets.svgs.icons.search.svg(
                      height: 20.w,
                      width: 20.w,
                    )
                  : Icon(Symbols.cancel_rounded, color: AppColors.text200, fill: 1),
            );
          },
        ),
      ),
      textInputAction: TextInputAction.search,
      onSubmitted: (value) {
        if (value != null && value.isNotEmpty) {
          controller.search(value);
        }
      },
    );
  }

  Widget _buildEmptyQueries() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        spacing: 24.h,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 12.h,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Từ khoá đã tìm",
                      style: AppTextStyles.heading5.copyWith(color: AppColors.text500),
                    ),
                    Obx(() {
                      if (controller.myKeywords.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return GestureDetector(
                        onTap: () {
                          controller.clearMyKeywords();
                        },
                        child: Text(
                          "Xoá",
                          style: AppTextStyles.body12.copyWith(color: AppColors.text300),
                        ),
                      );
                    }),
                  ],
                ),
                Obx(() {
                  if (controller.myKeywords.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return Wrap(
                    spacing: 12.w,
                    runSpacing: 12.h,
                    children: controller.myKeywords.map(
                      (keyword) {
                        Color backgroundColor = Colors.white;
                        Color borderColor = AppColors.bg500;
                        Color textColor = AppColors.text300;

                        return GestureDetector(
                          onTap: () {
                            controller.searchTextController.text = keyword.keyword;
                            controller.search(keyword.keyword);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: borderColor, width: 1.w),
                            ),
                            child: Text(
                              keyword.keyword,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.body12.copyWith(color: textColor),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyResults() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Column(
        spacing: 54.h,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Không có kết quả cho "${controller.submittedQuery.value}"',
            style: AppTextStyles.heading5.copyWith(color: AppColors.text500),
          ),
          Center(
            child: Column(
              spacing: 8.h,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.svgs.icons.searchNoResult.svg(
                  width: 130.w,
                  height: 130.w,
                ),
                Text(
                  'Không tìm thấy sản phẩm nào phù hợp',
                  style: AppTextStyles.body14.copyWith(color: AppColors.text400),
                ),
              ],
            ),
          ),
          Column(
            spacing: 16.h,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Có thể bạn thích",
                style: AppTextStyles.heading5.copyWith(color: AppColors.text500),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 164.w / 228.h,
                  mainAxisSpacing: 16.h,
                  crossAxisSpacing: 16.w,
                ),
                itemCount: 8,
                itemBuilder: (context, index) => HomeProductWidget(
                  onTap: () => Get.toNamed(
                    AppPageNames.productDetail.replaceAll(':id', 'product-$index'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 36.h,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  // Get.bottomSheet(
                  //   SortBottomsheet(selectedSlug: controller.selectedCollectionIndex.value),
                  //   backgroundColor: Colors.white,
                  //   isScrollControlled: true,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.only(
                  //       topLeft: Radius.circular(16.r),
                  //       topRight: Radius.circular(16.r),
                  //     ),
                  //   ),
                  // );
                },
                child: Row(
                  spacing: 4.w,
                  children: [
                    Icon(Symbols.south_rounded, color: AppColors.primary500, size: 16.w),
                    Text(
                      "Sắp xếp: Bán chạy nhất",
                      style: AppTextStyles.body12.copyWith(
                        color: AppColors.primary500,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    FilterBottomsheet(selectedSubCategory: Get.find<CatalogController>().selectedSubCategory.value!),
                    backgroundColor: Colors.white,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        topRight: Radius.circular(16.r),
                      ),
                    ),
                  );
                },
                child: Row(
                  spacing: 4.w,
                  children: [
                    Assets.svgs.icons.filter.svg(width: 16.w, height: 16.w, colorFilter: ColorFilter.mode(AppColors.text500, BlendMode.srcIn)),
                    Text(
                      "Lọc",
                      style: AppTextStyles.body12.copyWith(
                        color: AppColors.text500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            // padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            child: Column(
              spacing: 16.h,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Collection row replaces "Kết quả cho ..." title
                Obx(() {
                  // Try to get HomeController, fallback to empty list if not available
                  HomeController? homeController;
                  try {
                    homeController = Get.find<HomeController>();
                  } catch (e) {
                    homeController = null;
                  }
                  final collections = homeController?.collectionList.value?.rows ?? [];

                  if (collections.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return SizedBox(
                    height: 28.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final collection = collections[index];
                        final isSelected = controller.selectedCollectionIndex.value == index;
                        Color textColor = isSelected ? AppColors.primary500 : AppColors.text500;
                        TextStyle textStyle = (isSelected ? AppTextStyles.label12 : AppTextStyles.body12).copyWith(
                          color: textColor,
                        );

                        return GestureDetector(
                          onTap: () {
                            controller.selectedCollectionIndex.value = index;
                            // Search products from this collection with current search query
                            controller.searchProducts(
                              collectionSlug: collection.slug,
                              search: controller.submittedQuery.value,
                              offset: 0,
                              limit: 20,
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            decoration: isSelected
                                ? BoxDecoration(
                                    color: AppColors.primary100,
                                    borderRadius: BorderRadius.circular(4.r),
                                  )
                                : null,
                            child: Center(
                              child: Text(
                                collection.name,
                                style: textStyle,
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        width: 12.w,
                        height: 28.h,
                        child: Center(
                          child: Container(
                            width: 4.w,
                            height: 4.w,
                            decoration: BoxDecoration(
                              color: AppColors.text100,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      itemCount: collections.length,
                    ),
                  );
                }),
                Obx(() {
                  final searchResult = controller.searchResult.value;
                  if (searchResult == null || searchResult.rows.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return MasonryGridView.count(
                    clipBehavior: Clip.none,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 8.w, bottom: 80.h),
                    crossAxisCount: 2,
                    mainAxisSpacing: 8.w,
                    crossAxisSpacing: 8.w,
                    itemCount: searchResult.rows.length,
                    itemBuilder: (context, index) {
                      // Show loading indicator at the bottom
                      var product = searchResult.rows[index];
                      return FinalProductCard(
                        product: product,
                      );
                    },
                  );

                  // return GridView.builder(
                  //   shrinkWrap: true,
                  //   physics: NeverScrollableScrollPhysics(),
                  //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 2,
                  //     childAspectRatio: 164.w / 228.h,
                  //     mainAxisSpacing: 16.h,
                  //     crossAxisSpacing: 16.w,
                  //   ),
                  //   itemCount: searchResult.rows.length,
                  //   itemBuilder: (context, index) => SearchProductWidget(
                  //     product: searchResult.rows[index],
                  //   ),
                  // );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
