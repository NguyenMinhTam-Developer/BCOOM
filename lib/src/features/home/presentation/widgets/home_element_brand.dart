import 'dart:convert';

import '../../../../core/theme/app_colors.dart';
import '../../domain/usecases/get_brand_list_usecase.dart';
import 'section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/home_brand_controller.dart';
import 'section_background.dart';

class HomeElementBrand extends StatefulWidget {
  const HomeElementBrand({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<HomeElementBrand> createState() => _HomeElementBrandState();
}

class _HomeElementBrandState extends State<HomeElementBrand> {
  late final HomeBrandController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(
      HomeBrandController(getBrandListUseCase: Get.find<GetBrandListUseCase>()),
      tag: (widget.key as ValueKey<String>).value,
    );

    Map<String, dynamic> keywords = jsonDecode(widget.data['keywords']);

    _controller.getBrandList(
      limit: num.tryParse(keywords['limit']?.toString() ?? '0'),
    );
  }

  @override
  void dispose() {
    Get.delete<HomeBrandController>(tag: (widget.key as ValueKey<String>).value);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16.h,
            children: [
              SectionTitle(
                rawTitle: widget.data['title']?.toString() ?? '',
                content: widget.data['content']?.toString() ?? '',
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: AspectRatio(
                  aspectRatio: 440 / 366,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: SectionBackground(
                      imageUrl: widget.data['image_url'],
                      imageLocation: widget.data['image_location'],
                      usePositioned: false,
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Obx(
                  () => Row(
                    spacing: 16.w,
                    children: List.generate(_controller.brandList.value?.rows.length ?? 0, (index) {
                      var itemImageUrl = _controller.brandList.value?.rows[index].imageUrl;
                      var itemImageLocation = _controller.brandList.value?.rows[index].imageLocation;

                      return Container(
                        width: (Get.width - (16.w * (2 + 1))) / 2,
                        height: (Get.width - (16.w * (2 + 1))) / 2,
                        clipBehavior: Clip.hardEdge,
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColors.pink8, width: 1.w),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: SectionBackground(
                          imageUrl: itemImageUrl,
                          imageLocation: itemImageLocation,
                          usePositioned: false,
                          fit: BoxFit.contain,
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
