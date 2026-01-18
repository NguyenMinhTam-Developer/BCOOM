import '../../core/theme/app_colors.dart';
import '../typography/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputLabel extends StatelessWidget {
  final String? label;
  final Widget? child;
  final bool isRequired;

  const InputLabel({
    super.key,
    this.label,
    this.child,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.h,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null)
          Row(
            children: [
              Text(label!, style: AppTextStyles.body12.copyWith(color: AppColors.text500)),
              if (isRequired) Text('*'),
            ],
          ),
        if (child != null) child!,
      ],
    );
  }
}
