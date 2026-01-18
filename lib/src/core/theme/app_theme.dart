import 'app_colors.dart';
import '../../shared/typography/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final _textTheme = GoogleFonts.interTextTheme(
    TextTheme(
      // Display
      displayLarge: TextStyle(fontSize: 57.sp, fontWeight: FontWeight.w400), // Display Large
      displayMedium: TextStyle(fontSize: 45.sp, fontWeight: FontWeight.w400), // Display Medium
      displaySmall: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.w400), // Display Small

      // Headline
      headlineLarge: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w400), // Headline Large
      headlineMedium: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w400), // Headline Medium
      headlineSmall: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400), // Headline Small

      // Title
      titleLarge: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w400), // Title Large
      titleMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500), // Title Medium
      titleSmall: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500), // Title Small

      // Label
      labelLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500), // Label Large
      labelMedium: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500), // Label Medium
      labelSmall: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500), // Label Small

      // Body
      bodyLarge: AppTextStyles.body14.copyWith(color: AppColors.text500), // Body Large
      bodyMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400), // Body Medium
      bodySmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400), // Body Small
    ),
  );

  static final _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF455A64),
      foregroundColor: Colors.white,
      disabledBackgroundColor: Color(0xFF455A64).withValues(alpha: .30),
      disabledForegroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      textStyle: GoogleFonts.barlowSemiCondensed(fontSize: 12, fontWeight: FontWeight.w700),
    ),
  );

  static final _filledButtonTheme = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
      disabledBackgroundColor: AppColors.primaryColor.withValues(alpha: 0.3),
      disabledForegroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 32.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      textStyle: GoogleFonts.barlowSemiCondensed(fontSize: 16, fontWeight: FontWeight.w700),
    ),
  );

  static final _outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.primaryColor,
      disabledBackgroundColor: AppColors.primaryColor.withValues(alpha: 0.3),
      disabledForegroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 32.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      textStyle: GoogleFonts.barlowSemiCondensed(fontSize: 16, fontWeight: FontWeight.w700),
    ),
  );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
        dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
      ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: AppTextStyles.heading4.copyWith(color: AppColors.text500),
      ),
      textTheme: _textTheme,
      fontFamily: GoogleFonts.inter().fontFamily,
      elevatedButtonTheme: _elevatedButtonTheme,
      filledButtonTheme: _filledButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      cardTheme: CardThemeData(
        elevation: 0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),

      // Inputs
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: AppTextStyles.body14.copyWith(color: AppColors.text200),
        labelStyle: AppTextStyles.body12.copyWith(color: AppColors.text500),
        helperStyle: AppTextStyles.body12.copyWith(color: AppColors.text200),
        errorStyle: AppTextStyles.body12.copyWith(color: AppColors.error500),
        filled: true,
        fillColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.bg400;
          }
          return Colors.white;
        }),
        prefixIconColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.text200;
          }
          if (states.contains(WidgetState.focused)) {
            return AppColors.text500; // When focused
          }
          return AppColors.text200; // When not focused
        }),
        suffixIconColor: WidgetStateColor.resolveWith((Set<WidgetState> states) {
          if (states.contains(WidgetState.disabled)) {
            return AppColors.text200;
          }
          if (states.contains(WidgetState.focused)) {
            return AppColors.text500; // When focused
          }
          return AppColors.text200; // When not focused
        }),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.bg500),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.text300),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.error500),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.bg300),
        ),
      ),
    );
  }
}
