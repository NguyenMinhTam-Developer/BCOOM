import 'dart:math';

import '../../../../core/routers/app_page_names.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../../../../generated/assets.gen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/components/buttons.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../controllers/catalog_controller.dart';
import '../widgets/brand_widget.dart';
import '../widgets/category_widget.dart';
import '../widgets/subcategory_widget.dart';

class CatalogPage extends GetView<CatalogController> {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Danh mục"),
          actions: [
            AppIconButton(
              onPressed: () {
                Get.toNamed(AppPageNames.catalogSearch);
              },
              icon: Assets.svgs.icons.search.svg(),
            ),
            SizedBox(width: 16.w),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildBrandList(),
            Expanded(
              child: _buildProductSection(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandList() {
    final brandList = controller.brandList.value?.rows ?? [];
    return Container(
      clipBehavior: Clip.none,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.bg500, width: 1.w)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFADADAD).withValues(alpha: 0.05),
            blurRadius: 26.r,
            offset: Offset(4.w, 4.h),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Row(
          spacing: 16.w,
          children: [
            InkWell(
              onTap: () => controller.selectedBrandId.value = null,
              child: Container(
                height: 56.w,
                width: 56.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: controller.selectedBrandId.value == null ? Border.all(color: AppColors.primary500, width: 1.w) : Border.all(color: AppColors.bg500, width: 1.w),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Assets.svgs.icons.categories.svg(
                      width: 24.w,
                      height: 24.w,
                    ),
                    GradientText(
                      "Tất cả",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.label10,
                      colors: AppColors.linear9.colors,
                    ),
                  ],
                ),
              ),
            ),
            ...List.generate(
              brandList.length,
              (index) => BrandWidget(
                brand: brandList[index],
                onTap: () => controller.selectedBrandId.value = brandList[index].id,
                isSelected: controller.selectedBrandId.value == brandList[index].id,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCategoryList(),
        // Expanded(child: _buildProductList()),
        Expanded(child: _buildSubCategoryList()),
      ],
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      // Include extra width for the arrow button (76 + 18 = 94)
      width: controller.isExpanded.value ? 94.w : 18.w,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // Category list
          Container(
            width: controller.isExpanded.value ? 76.w : 0.w,
            color: Colors.white,
            child: ListView.separated(
              itemCount: controller.categoryList.length,
              separatorBuilder: (BuildContext context, int index) {
                return DottedLine(
                  dashColor: AppColors.text200,
                  dashLength: 4.w,
                  dashGapLength: 4.w,
                  lineThickness: 1.w,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                final category = controller.categoryList[index];

                return CategoryWidget(
                  isSelected: controller.selectedMainCategory.value?.slug == category.slug,
                  name: category.name,
                  onTap: () => controller.onCategoryTap(category),
                );
              },
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: 36.h,
              width: 18.w,
              color: Colors.white,
            ),
          ),
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap: () => controller.isExpanded.value = !controller.isExpanded.value,
              child: Container(
                height: 64.h,
                width: 18.w,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 30.r,
                      offset: Offset(0, 4.h),
                    ),
                  ],
                  color: Colors.white.withValues(alpha: controller.isExpanded.value ? 0.5 : 1),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(18.r),
                    bottomRight: Radius.circular(18.r),
                  ),
                ),
                child: Transform.rotate(
                  angle: controller.isExpanded.value ? 0 : pi,
                  child: Assets.svgs.icons.leftArrown.svg(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubCategoryList() {
    final selectedCategory = controller.selectedMainCategory.value;
    final subcategories = selectedCategory?.children ?? [];

    return Column(
      spacing: 16.h,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          selectedCategory?.name ?? '',
          style: AppTextStyles.heading6.copyWith(
            color: AppColors.text500,
          ),
        ),
        Expanded(
          child: subcategories.isEmpty
              ? Center(
                  child: Text(
                    'Không có danh mục con',
                    style: AppTextStyles.body14.copyWith(
                      color: AppColors.text200,
                    ),
                  ),
                )
              : GridView.builder(
                  padding: EdgeInsets.only(right: 16.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 4 / 5,
                    mainAxisSpacing: 8.h,
                    crossAxisSpacing: 14.w,
                  ),
                  itemCount: subcategories.length,
                  itemBuilder: (context, index) {
                    final subcategory = subcategories[index];
                    return SubCategoryWidget(
                      name: subcategory.category.name,
                      onTap: () => controller.onSubCategoryTap(subcategory),
                    );
                  },
                ),
        ),
      ],
    );
  }

  // Widget _buildProductList() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.stretch,
  //     children: [
  //       Container(
  //         height: 36.h,
  //         color: Colors.white,
  //         padding: EdgeInsets.only(right: 16.w),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Expanded(
  //               child: GestureDetector(
  //                 onTap: () async {
  //                   final String? selectedSlug = await Get.bottomSheet(
  //                     SortBottomsheet(selectedSlug: controller.selectedCollectionSlug.value),
  //                     backgroundColor: Colors.white,
  //                     isScrollControlled: true,
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.only(
  //                         topLeft: Radius.circular(16.r),
  //                         topRight: Radius.circular(16.r),
  //                       ),
  //                     ),
  //                   );

  //                   if (selectedSlug != null) {
  //                     controller.selectedCollectionSlug.value = selectedSlug;
  //                   }
  //                 },
  //                 child: Row(
  //                   spacing: 4.w,
  //                   children: [
  //                     Icon(Symbols.south_rounded, color: AppColors.primary500, size: 16.w),
  //                     Expanded(
  //                       child: Obx(
  //                         () => Text(
  //                           "Sắp xếp: ${controller.collectionList.value?.rows.where((element) => element.slug == controller.selectedCollectionSlug.value).firstOrNull?.name ?? ''}",
  //                           maxLines: 1,
  //                           overflow: TextOverflow.ellipsis,
  //                           style: AppTextStyles.body12.copyWith(
  //                             color: AppColors.primary500,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //             GestureDetector(
  //               onTap: () {
  //                 Get.bottomSheet(
  //                   FilterBottomsheet(),
  //                   backgroundColor: Colors.white,
  //                   isScrollControlled: true,
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.only(
  //                       topLeft: Radius.circular(16.r),
  //                       topRight: Radius.circular(16.r),
  //                     ),
  //                   ),
  //                 );
  //               },
  //               child: Row(
  //                 spacing: 4.w,
  //                 children: [
  //                   Assets.svgs.icons.filter.svg(width: 16.w, height: 16.w, colorFilter: ColorFilter.mode(AppColors.text500, BlendMode.srcIn)),
  //                   Text(
  //                     "Lọc",
  //                     style: AppTextStyles.body12.copyWith(
  //                       color: AppColors.text500,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       Expanded(
  //         child: GridView.builder(
  //           padding: EdgeInsets.only(right: 16.w, top: 16.h, bottom: 16.h),
  //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //             crossAxisCount: 2,
  //             childAspectRatio: 126.w / 203.h,
  //             mainAxisSpacing: 8.h,
  //             crossAxisSpacing: 14.w,
  //           ),
  //           itemCount: controller.productList.value?.rows.length ?? 0,
  //           itemBuilder: (context, index) => CatalogProductCard(
  //             product: controller.productList.value!.rows[index],
  //           ),
  //           // itemBuilder: (context, index) => Obx(() => controller.isExpanded.value
  //           //     ? CatalogProductWidget(
  //           //         product: controller.productList.value?.rows[index],
  //           //         onTap: () => Get.toNamed(
  //           //           AppPageNames.productDetail.replaceAll(':id', 'product-$index'),
  //           //         ),
  //           //       )
  //           //     : HomeProductWidget(
  //           //         onTap: () => Get.toNamed(
  //           //           AppPageNames.productDetail.replaceAll(':id', 'product-$index'),
  //           //         ),
  //           //       )),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
