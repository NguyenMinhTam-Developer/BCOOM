import 'core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../flavors.dart';
import 'core/routers/app_page_names.dart';
import 'core/routers/app_pages.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: GetMaterialApp(
          title: F.title,
          theme: AppTheme.lightTheme,
          initialRoute: AppPageNames.initial,
          getPages: AppPages.pages,
        ),
      ),
    );
  }
}
