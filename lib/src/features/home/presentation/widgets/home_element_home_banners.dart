import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeElementHomeBanners extends StatelessWidget {
  const HomeElementHomeBanners({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    final List<dynamic> items = data['items'] ?? [];

    final List<dynamic> bannerOneItems = items.where((item) => item['ordering'] == 1).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 825.w / 450.h,
          child: PageView.builder(
            itemCount: bannerOneItems.length,
            itemBuilder: (context, index) {
              final Map<String, dynamic> item = bannerOneItems[index] as Map<String, dynamic>;

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider('${item['image_url']}${item['image_location']}'),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
