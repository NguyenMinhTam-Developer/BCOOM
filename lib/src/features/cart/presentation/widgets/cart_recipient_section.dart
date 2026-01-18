import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/typography/app_text_styles.dart';
import '../../domain/entities/cart_info_entity.dart';

class CartRecipientSection extends StatelessWidget {
  final CartShippingAddressEntity? shippingAddress;
  final VoidCallback onChangeAddress;

  const CartRecipientSection({
    super.key,
    required this.shippingAddress,
    required this.onChangeAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Thông tin người nhận',
                style: AppTextStyles.heading5.copyWith(
                  color: AppColors.text500,
                ),
              ),
              TextButton(
                onPressed: onChangeAddress,
                child: Text(
                  'Đổi',
                  style: AppTextStyles.body14.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          if (shippingAddress != null) ...[
            _InfoRow(
              label: 'Họ tên',
              value: shippingAddress!.name ?? 'Chưa có',
            ),
            SizedBox(height: 8.h),
            _InfoRow(
              label: 'Số điện thoại',
              value: shippingAddress!.phone ?? 'Chưa có',
            ),
            SizedBox(height: 8.h),
            _InfoRow(
              label: 'Địa chỉ',
              value: _buildFullAddress(shippingAddress!),
            ),
          ] else ...[
            Text(
              'Chưa có địa chỉ giao hàng',
              style: AppTextStyles.body14.copyWith(
                color: AppColors.text200,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _buildFullAddress(CartShippingAddressEntity address) {
    final parts = <String>[];
    if (address.street != null && address.street!.isNotEmpty) {
      parts.add(address.street!);
    }
    if (address.ward != null && address.ward!.isNotEmpty) {
      parts.add(address.ward!);
    }
    if (address.district != null && address.district!.isNotEmpty) {
      parts.add(address.district!);
    }
    if (address.province != null && address.province!.isNotEmpty) {
      parts.add(address.province!);
    }
    return parts.isEmpty ? 'Chưa có' : parts.join(', ');
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100.w,
          child: Text(
            label,
            style: AppTextStyles.body14.copyWith(
              color: AppColors.text300,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.body14.copyWith(
              color: AppColors.text500,
            ),
          ),
        ),
      ],
    );
  }
}
