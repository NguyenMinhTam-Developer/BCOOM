import 'package:bcoom/src/features/catalog/presentation/controllers/catalog_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/components/buttons.dart';
import '../../../../shared/typography/app_text_styles.dart';

class SortBottomsheet extends StatefulWidget {
  const SortBottomsheet({super.key, required this.selectedSlug});

  final String? selectedSlug;

  @override
  State<SortBottomsheet> createState() => _SortBottomsheetState();
}

class _SortBottomsheetState extends State<SortBottomsheet> {
  final catalogController = Get.find<CatalogController>();

  late String? _selectedSlug;

  @override
  void initState() {
    super.initState();
    _selectedSlug = widget.selectedSlug;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 60.h,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.bg500, width: 1.w),
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Sắp xếp theo",
                    style: AppTextStyles.heading5.copyWith(color: AppColors.text500),
                  ),
                ),
                Positioned(
                  right: 16.w,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: SecondaryIconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(Icons.close),
                    ),
                  ),
                )
              ],
            ),
          ),
          // Wrap in Flexible + SingleChildScrollView to fit content and scroll if needed
          Flexible(
            fit: FlexFit.loose,
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: catalogController.collectionList.value?.rows
                          .map(
                            (e) => RadioListTile(
                              fillColor: WidgetStateProperty.resolveWith((state) {
                                if (state.contains(WidgetState.selected)) {
                                  return AppColors.secondary500;
                                }
                                return AppColors.text100;
                              }),
                              title: Text(
                                e.name,
                                style: AppTextStyles.body14.copyWith(color: AppColors.text400),
                              ),
                              value: e.slug,
                              groupValue: _selectedSlug,
                              onChanged: (value) {
                                setState(() {
                                  _selectedSlug = e.slug;
                                });

                                Get.back(result: _selectedSlug);
                              },
                            ),
                          )
                          .toList() ??
                      [],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
