import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/coupon_entity.dart';

class CouponApplicabilityModel extends CouponApplicabilityEntity {
  CouponApplicabilityModel({
    required super.canApply,
    required super.reason,
    required super.discountAmount,
  });

  factory CouponApplicabilityModel.fromJson(Map<String, dynamic> json) {
    return CouponApplicabilityModel(
      canApply: JsonMapperUtils.safeParseBool(json['can_apply']),
      reason: JsonMapperUtils.safeParseString(json['reason']),
      discountAmount: JsonMapperUtils.safeParseDouble(json['discount_amount']),
    );
  }
}

class CouponCategoryModel extends CouponCategoryEntity {
  CouponCategoryModel({
    required super.id,
    required super.name,
    super.parentCategoryId,
  });

  factory CouponCategoryModel.fromJson(Map<String, dynamic> json) {
    return CouponCategoryModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      name: JsonMapperUtils.safeParseString(json['name']),
      parentCategoryId: JsonMapperUtils.safeParseIntNullable(json['parent_category_id']),
    );
  }
}

class CouponBrandModel extends CouponBrandEntity {
  CouponBrandModel({
    required super.id,
    required super.name,
    required super.logo,
  });

  factory CouponBrandModel.fromJson(Map<String, dynamic> json) {
    return CouponBrandModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      name: JsonMapperUtils.safeParseString(json['name']),
      logo: JsonMapperUtils.safeParseString(json['logo']),
    );
  }
}

class CouponProductModel extends CouponProductEntity {
  CouponProductModel({
    required super.id,
    required super.name,
    required super.code,
  });

  factory CouponProductModel.fromJson(Map<String, dynamic> json) {
    return CouponProductModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      name: JsonMapperUtils.safeParseString(json['name']),
      code: JsonMapperUtils.safeParseString(json['code']),
    );
  }
}

class CouponSellerModel extends CouponSellerEntity {
  CouponSellerModel({
    required super.id,
    required super.slug,
    required super.name,
    required super.logo,
  });

  factory CouponSellerModel.fromJson(Map<String, dynamic> json) {
    return CouponSellerModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      slug: JsonMapperUtils.safeParseString(json['slug']),
      name: JsonMapperUtils.safeParseString(json['name']),
      logo: JsonMapperUtils.safeParseString(json['logo']),
    );
  }
}

class CouponPromotionModel extends CouponPromotionEntity {
  CouponPromotionModel({
    required super.id,
    required super.code,
    required super.type,
    required super.name,
    required super.discountMethod,
    required super.discountValue,
    required super.discountCode,
    super.minOrderValue,
    super.maxDiscountAmount,
    required super.endDate,
    required super.applyType,
    super.description,
    required super.site,
    required super.products,
    required super.categories,
    required super.brands,
    super.seller,
  });

  factory CouponPromotionModel.fromJson(Map<String, dynamic> json) {
    return CouponPromotionModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      code: JsonMapperUtils.safeParseString(json['code']),
      type: JsonMapperUtils.safeParseString(json['type']),
      name: JsonMapperUtils.safeParseString(json['name']),
      discountMethod: JsonMapperUtils.safeParseString(json['discount_method']),
      discountValue: JsonMapperUtils.safeParseString(json['discount_value']),
      discountCode: JsonMapperUtils.safeParseString(json['discount_code']),
      minOrderValue: JsonMapperUtils.safeParseStringNullable(json['min_order_value']),
      maxDiscountAmount: JsonMapperUtils.safeParseStringNullable(json['max_discount_amount']),
      endDate: JsonMapperUtils.safeParseString(json['end_date']),
      applyType: JsonMapperUtils.safeParseString(json['apply_type']),
      description: JsonMapperUtils.safeParseStringNullable(json['description']),
      site: JsonMapperUtils.safeParseString(json['site']),
      products: JsonMapperUtils.safeParseList(
        json['products'],
        mapper: (e) => CouponProductModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
      categories: JsonMapperUtils.safeParseList(
        json['categories'],
        mapper: (e) => CouponCategoryModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
      brands: JsonMapperUtils.safeParseList(
        json['brands'],
        mapper: (e) => CouponBrandModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
      seller: json['seller'] != null
          ? CouponSellerModel.fromJson(
              JsonMapperUtils.safeParseMap(json['seller']),
            )
          : null,
    );
  }
}

class PlatformCouponModel extends PlatformCouponEntity {
  PlatformCouponModel({
    required super.id,
    required super.promotionId,
    required super.voucherCode,
    required super.source,
    required super.promotion,
    required super.applicability,
  });

  factory PlatformCouponModel.fromJson(Map<String, dynamic> json) {
    return PlatformCouponModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      promotionId: JsonMapperUtils.safeParseInt(json['promotion_id']),
      voucherCode: JsonMapperUtils.safeParseString(json['voucher_code']),
      source: JsonMapperUtils.safeParseString(json['source']),
      promotion: CouponPromotionModel.fromJson(
        JsonMapperUtils.safeParseMap(json['promotion']),
      ),
      applicability: CouponApplicabilityModel.fromJson(
        JsonMapperUtils.safeParseMap(json['applicability']),
      ),
    );
  }
}

class SellerCouponModel extends SellerCouponEntity {
  SellerCouponModel({
    required super.id,
    super.userVoucherId,
    required super.voucherCode,
    required super.source,
    super.savedAt,
    super.expiredAt,
    required super.promotion,
    required super.applicability,
  });

  factory SellerCouponModel.fromJson(Map<String, dynamic> json) {
    return SellerCouponModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      userVoucherId: JsonMapperUtils.safeParseIntNullable(json['user_voucher_id']),
      voucherCode: JsonMapperUtils.safeParseString(json['voucher_code']),
      source: JsonMapperUtils.safeParseString(json['source']),
      savedAt: JsonMapperUtils.safeParseStringNullable(json['saved_at']),
      expiredAt: JsonMapperUtils.safeParseStringNullable(json['expired_at']),
      promotion: CouponPromotionModel.fromJson(
        JsonMapperUtils.safeParseMap(json['promotion']),
      ),
      applicability: CouponApplicabilityModel.fromJson(
        JsonMapperUtils.safeParseMap(json['applicability']),
      ),
    );
  }
}

class PlatformCouponsModel extends PlatformCouponsEntity {
  PlatformCouponsModel({
    required super.discountCode,
    required super.freeShipping,
  });

  factory PlatformCouponsModel.fromJson(Map<String, dynamic> json) {
    return PlatformCouponsModel(
      discountCode: JsonMapperUtils.safeParseList(
        json['discount_code'],
        mapper: (e) => PlatformCouponModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
      freeShipping: JsonMapperUtils.safeParseList(
        json['free_shipping'],
        mapper: (e) => PlatformCouponModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
    );
  }
}

class SellerCouponsModel extends SellerCouponsEntity {
  SellerCouponsModel({
    required super.discountCode,
    required super.freeShipping,
  });

  factory SellerCouponsModel.fromJson(Map<String, dynamic> json) {
    return SellerCouponsModel(
      discountCode: JsonMapperUtils.safeParseList(
        json['discount_code'],
        mapper: (e) => SellerCouponModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
      freeShipping: JsonMapperUtils.safeParseList(
        json['free_shipping'],
        mapper: (e) => SellerCouponModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
    );
  }
}
