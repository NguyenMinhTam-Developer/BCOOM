import 'package:bcoom/src/features/catalog/domain/entities/product_sub_side_bar_entity.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/components/buttons.dart';
import '../../../../shared/typography/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/catalog_controller.dart';

class FilterBottomsheet extends StatefulWidget {
  const FilterBottomsheet({
    super.key,
    required this.selectedSubCategory,
  });

  final ProductSubSideBarEntity selectedSubCategory;

  @override
  State<FilterBottomsheet> createState() => _FilterBottomsheetState();
}

class _FilterBottomsheetState extends State<FilterBottomsheet> {
  final catalogController = Get.find<CatalogController>();

  Map<int, int?> selectedPrices = {};
  Map<int, int?> selectedFilters = {};
  int? selectedCategories;

  @override
  void initState() {
    super.initState();
  }

  void _applyFilters() {
    Get.back();
  }

  void _resetFilters() {
    setState(() {
      selectedPrices.clear();
      selectedFilters.clear();
      selectedCategories = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            // maxHeight: MediaQuery.of(context).size.height * 0.7,
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
                  Positioned(
                    left: 16.w,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: _resetFilters,
                        child: Text(
                          "Bỏ chọn",
                          style: AppTextStyles.label12.copyWith(color: AppColors.text200),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Bộ lọc chi tiết",
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
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 20.h,
                  children: [
                    // Price filter section
                    if (widget.selectedSubCategory.prices.isNotEmpty)
                      _buildFilterSection(
                        title: 'Giá',
                        items: widget.selectedSubCategory.prices.map((e) => (e.id.toInt(), e.name)).toList(),
                        selectedItems: selectedPrices.keys.toList(),
                        onChanged: (value) {
                          setState(() {
                            if (selectedPrices.containsKey(value)) {
                              selectedPrices.remove(value);
                            } else {
                              selectedPrices[value] = value;
                            }
                          });
                        },
                        isPrice: true,
                      ),
                    // Filter sections
                    ...widget.selectedSubCategory.filters.map((filterSection) {
                      return _buildFilterSection(
                        title: filterSection.filterCategoryName,
                        items: filterSection.filters.map((e) => (e.filterId.toInt(), e.filterName)).toList(),
                        selectedItems: selectedFilters.keys.toList(),
                        onChanged: (value) {
                          setState(() {
                            if (selectedFilters.containsKey(value)) {
                              selectedFilters.remove(value);
                            } else {
                              selectedFilters[value] = value;
                            }
                          });
                        },
                      );
                    }),
                    // Category children filter section
                    if (widget.selectedSubCategory.category.children.isNotEmpty)
                      _buildFilterSection(
                        title: widget.selectedSubCategory.category.name,
                        items: widget.selectedSubCategory.category.children.map((e) => (e.id.toInt(), e.name)).toList(),
                        selectedItems: selectedCategories != null ? [selectedCategories!] : [],
                        onChanged: (value) {
                          setState(() {
                            if (selectedCategories == value) {
                              selectedCategories = null;
                            } else {
                              selectedCategories = value;
                            }
                          });
                        },
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: AppButton.primary(
                onPressed: _applyFilters,
                label: "Áp dụng bộ lọc",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection({
    required String title,
    required List<(int, String)> items,
    required List<int>? selectedItems,
    required Function(int) onChanged,
    bool isPrice = false,
  }) {
    return Column(
      spacing: 12.h,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: AppTextStyles.heading5.copyWith(color: AppColors.text500),
        ),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: items.map(
            (e) {
              bool isSelected = selectedItems?.contains(e.$1) ?? false;
              Color backgroundColor = isSelected ? AppColors.secondary100 : Colors.white;
              Color borderColor = isSelected ? AppColors.secondary500 : AppColors.bg500;
              Color textColor = isSelected ? AppColors.secondary500 : AppColors.text300;
              return GestureDetector(
                onTap: () => onChanged(e.$1),
                child: Container(
                  width: isPrice ? Get.size.width * 0.5 - 24.w : null,
                  height: isPrice ? 40.h : null,
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: borderColor, width: 1.w),
                  ),
                  child: Text(
                    e.$2,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body12.copyWith(color: textColor),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
