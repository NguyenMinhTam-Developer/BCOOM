import '../../../../core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../home/domain/entities/brand_entity.dart';

class BrandWidget extends StatelessWidget {
  const BrandWidget({super.key, required this.brand, required this.onTap, required this.isSelected});

  final BrandEntity brand;
  final VoidCallback onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 56.w,
        width: 56.w,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.bg500, width: 1.w),
          image: DecorationImage(
            image: NetworkImage('${brand.imageUrl}${brand.imageLocation}'),
            fit: BoxFit.contain,
          ),
        ),
        foregroundDecoration: BoxDecoration(
          shape: BoxShape.circle,
          border: isSelected ? Border.all(color: AppColors.primary500, width: 1.w) : Border.all(color: AppColors.bg500, width: 1.w),
        ),
      ),
    );
  }
}
