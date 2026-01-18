import 'package:bcoom/generated/assets.gen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../../domain/entities/faq_category_entity.dart';
import '../controllers/faq_list_controller.dart';

class FaqListPage extends GetView<FaqListController> {
  const FaqListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Symbols.arrow_back,
            color: AppColors.text500,
            size: 24.sp,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Câu hỏi thường gặp',
          style: AppTextStyles.heading4.copyWith(
            color: AppColors.text500,
          ),
        ),
        centerTitle: false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        }

        if (controller.categories.isEmpty) {
          return Center(
            child: Text(
              'Không có danh mục nào',
              style: AppTextStyles.body14.copyWith(
                color: AppColors.text400,
              ),
            ),
          );
        }

        return SafeArea(
          child: ListView.separated(
            padding: EdgeInsets.all(16.w),
            itemCount: controller.categories.length,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final category = controller.categories[index];
              return _buildCategoryCard(category);
            },
          ),
        );
      }),
    );
  }

  Widget _buildCategoryCard(FaqCategoryEntity category) {
    return InkWell(
      onTap: () => controller.onCategoryTap(category),
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            spacing: 16.w,
            children: [
              // Icon
              Container(
                width: 52.w,
                height: 52.w,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Color(0xFFFFDFEA),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: category.imageView,
                    height: 32.w,
                    width: 32.w,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Assets.logos.appIcon.image(),
                    ),
                  ),
                  // child: Icon(
                  //   _getCategoryIcon(category.name),
                  //   color: AppColors.primaryColor,
                  //   size: 24.sp,
                  // ),
                ),
              ),
              // Title and Description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4.h,
                  children: [
                    Text(
                      category.name,
                      style: AppTextStyles.label14.copyWith(
                        color: AppColors.primaryColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (category.description != null && category.description!.isNotEmpty)
                      Text(
                        category.description!,
                        style: AppTextStyles.body12.copyWith(
                          color: AppColors.text400,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              // Arrow icon
              Icon(
                Icons.arrow_forward_ios,
                size: 16.w,
                color: AppColors.text200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
