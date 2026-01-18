import '../../../../core/theme/app_colors.dart';
import 'section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'section_background.dart';

class HomeElementCommunity extends StatelessWidget {
  const HomeElementCommunity({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            SectionBackground(
              imageUrl: data['image_url'],
              imageLocation: data['image_location'],
            ),
            Positioned(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 16.h,
                  children: [
                    SectionTitle(
                      rawTitle: data['title']?.toString() ?? '',
                      content: data['content']?.toString() ?? '',
                      ctaTitle: 'Tham gia ngay',
                      padding: EdgeInsets.symmetric(horizontal: 16.w).copyWith(bottom: 160.h),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 250.h),
          child: FittedBox(
            fit: BoxFit.none,
            child: SizedBox(
              width: Get.width * 1.2,
              child: LayoutBuilder(builder: (context, constraints) {
                final scaleX = constraints.maxWidth / 1204;
                final scaleY = constraints.maxHeight / 716;
                final scale = scaleX < scaleY ? scaleX : scaleY;

                List<dynamic> items = data['items'];

                return SizedBox(
                  width: 1204 * scale,
                  height: 716 * scale,
                  child: Stack(
                    children: [
                      if (items.elementAtOrNull(0) != null)
                        Positioned(
                          top: 234 * scale,
                          left: 0,
                          width: 592 * scale,
                          height: 400 * scale,
                          child: _salesCommunityItemBackground(
                            scale,
                            items.elementAtOrNull(0)['image_url'],
                            items.elementAtOrNull(0)['image_location'],
                          ),
                        ),
                      if (items.elementAtOrNull(1) != null)
                        Positioned(
                          top: 0 * scale,
                          left: 616 * scale,
                          width: 286 * scale,
                          height: 350 * scale,
                          child: _salesCommunityItemBackground(
                            scale,
                            items.elementAtOrNull(1)['image_url'],
                            items.elementAtOrNull(1)['image_location'],
                          ),
                        ),
                      if (items.elementAtOrNull(2) != null)
                        Positioned(
                          top: 110 * scale,
                          right: 0 * scale,
                          width: 286 * scale,
                          height: 350 * scale,
                          child: _salesCommunityItemBackground(
                            scale,
                            items.elementAtOrNull(2)['image_url'],
                            items.elementAtOrNull(2)['image_location'],
                          ),
                        ),
                      if (items.elementAtOrNull(3) != null)
                        Positioned(
                          bottom: 0 * scale,
                          left: 616 * scale,
                          width: 286 * scale,
                          height: 350 * scale,
                          child: _salesCommunityItemBackground(
                            scale,
                            items.elementAtOrNull(3)['image_url'],
                            items.elementAtOrNull(3)['image_location'],
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget _salesCommunityItemBackground(double scale, String imageUrl, String imageLocation) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(350 * scale),
        color: AppColors.red8,
      ),
      child: SectionBackground(
        imageUrl: imageUrl,
        imageLocation: imageLocation,
        usePositioned: false,
      ),
    );
  }
}
