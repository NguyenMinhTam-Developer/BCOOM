import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/theme/app_colors.dart';
import '../typography/app_text_styles.dart';

enum ButtonSize {
  small,
  medium,
  large;

  double get height {
    switch (this) {
      case ButtonSize.small:
        return 36.h;
      case ButtonSize.medium:
        return 44.h;
      case ButtonSize.large:
        return 52.h;
    }
  }

  double get fontSize {
    switch (this) {
      case ButtonSize.small:
        return 12.sp;
      case ButtonSize.medium:
      case ButtonSize.large:
        return 14.sp;
    }
  }
}

enum ButtonVariant {
  primary,
  outline,
  ghost;

  Color get backgroundColor {
    switch (this) {
      case ButtonVariant.primary:
        return AppColors.secondaryPink;
      case ButtonVariant.outline:
        return Colors.transparent;
      case ButtonVariant.ghost:
        return Colors.transparent;
    }
  }

  Color get foregroundColor {
    switch (this) {
      case ButtonVariant.primary:
        return Colors.white;
      case ButtonVariant.outline:
      case ButtonVariant.ghost:
        return AppColors.primaryColor;
    }
  }

  TextStyle get textStyle {
    switch (this) {
      case ButtonVariant.primary:
        return AppTextStyles.label14;
      case ButtonVariant.outline:
        return AppTextStyles.label14;
      case ButtonVariant.ghost:
        return AppTextStyles.label14;
    }
  }
}

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final ButtonSize size;
  final ButtonVariant variant;
  final Widget? icon;
  final EdgeInsetsGeometry? padding;

  const AppButton._({
    super.key,
    required this.label,
    required this.onPressed,
    required this.size,
    required this.variant,
    this.icon,
    this.padding,
  });

  // Factory constructor for primary button
  factory AppButton.primary({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    ButtonSize size = ButtonSize.large,
    bool isLoading = false,
    Widget? icon,
    EdgeInsetsGeometry? padding,
  }) {
    return AppButton._(
      key: key,
      label: label,
      onPressed: onPressed,
      size: size,
      variant: ButtonVariant.primary,
      icon: icon,
      padding: padding,
    );
  }

  // Factory constructor for outline button
  factory AppButton.outline({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    ButtonSize size = ButtonSize.large,
    bool isLoading = false,
    Widget? icon,
    EdgeInsetsGeometry? padding,
  }) {
    return AppButton._(
      key: key,
      label: label,
      onPressed: onPressed,
      size: size,
      variant: ButtonVariant.outline,
      icon: icon,
      padding: padding,
    );
  }

  // Factory constructor for ghost button
  factory AppButton.ghost({
    Key? key,
    required String label,
    VoidCallback? onPressed,
    ButtonSize size = ButtonSize.large,
    bool isLoading = false,
    Widget? icon,
    EdgeInsetsGeometry? padding,
  }) {
    return AppButton._(
      key: key,
      label: label,
      onPressed: onPressed,
      size: size,
      variant: ButtonVariant.ghost,
      icon: icon,
      padding: padding,
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case ButtonVariant.primary:
        return FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: variant.backgroundColor,
            foregroundColor: variant.foregroundColor,
            textStyle: variant.textStyle,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            fixedSize: Size(double.infinity, size.height),
          ),
          child: Text(label),
        );
      case ButtonVariant.outline:
        return OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: variant.backgroundColor,
            foregroundColor: variant.foregroundColor,
            textStyle: variant.textStyle,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            fixedSize: Size(double.infinity, size.height),
          ),
          child: Text(label),
        );
      case ButtonVariant.ghost:
        return TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            backgroundColor: variant.backgroundColor,
            foregroundColor: variant.foregroundColor,
            textStyle: variant.textStyle,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            fixedSize: Size(double.infinity, size.height),
          ),
          child: Text(label),
        );
    }
  }
}

class CapsuleButton extends StatelessWidget {
  const CapsuleButton({super.key, required this.child, required this.onPressed});

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        backgroundColor: AppColors.primary500,
        foregroundColor: Colors.white,
        textStyle: AppTextStyles.body12,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(2.r),
            bottomLeft: Radius.circular(2.r),
            bottomRight: Radius.circular(12.r),
          ),
        ),
      ),
      child: child,
    );
  }
}

class AppIconButton extends StatelessWidget {
  const AppIconButton({super.key, required this.onPressed, required this.icon});

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    Widget effectiveIcon = icon;

    // Check if the icon is an SvgPicture, if so, clone it with required properties
    if (icon is SvgPicture) {
      final SvgPicture svgIcon = icon as SvgPicture;
      effectiveIcon = SvgPicture(
        svgIcon.bytesLoader,
        width: 20.0.h,
        height: 20.0.h,
        colorFilter: ColorFilter.mode(AppColors.primary500, BlendMode.srcIn),
        fit: svgIcon.fit,
        alignment: svgIcon.alignment,
        allowDrawingOutsideViewBox: svgIcon.allowDrawingOutsideViewBox,
        matchTextDirection: svgIcon.matchTextDirection,
        clipBehavior: svgIcon.clipBehavior,
        placeholderBuilder: svgIcon.placeholderBuilder,
        semanticsLabel: svgIcon.semanticsLabel,
        excludeFromSemantics: svgIcon.excludeFromSemantics,
      );
    }

    return Card(
      shape: CircleBorder(),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: AppColors.primary100,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: effectiveIcon,
          ),
        ),
      ),
    );
  }
}

class SecondaryIconButton extends StatelessWidget {
  const SecondaryIconButton({super.key, required this.onPressed, required this.icon});

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    Widget effectiveIcon = icon;

    // Check if the icon is an SvgPicture, if so, clone it with required properties
    if (icon is SvgPicture) {
      final SvgPicture svgIcon = icon as SvgPicture;
      effectiveIcon = SvgPicture(
        svgIcon.bytesLoader,
        width: 16.0.w,
        height: 16.0.w,
        colorFilter: ColorFilter.mode(AppColors.primary500, BlendMode.srcIn),
        fit: svgIcon.fit,
        alignment: svgIcon.alignment,
        allowDrawingOutsideViewBox: svgIcon.allowDrawingOutsideViewBox,
        matchTextDirection: svgIcon.matchTextDirection,
        clipBehavior: svgIcon.clipBehavior,
        placeholderBuilder: svgIcon.placeholderBuilder,
        semanticsLabel: svgIcon.semanticsLabel,
        excludeFromSemantics: svgIcon.excludeFromSemantics,
      );
    }

    return IconButton.filledTonal(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        minimumSize: Size(20.0.w, 20.0.w),
        padding: EdgeInsets.all(4.w),
        backgroundColor: AppColors.bg200,
        foregroundColor: AppColors.text500,
        shape: const CircleBorder(),
      ),
      icon: effectiveIcon,
    );
  }
}
