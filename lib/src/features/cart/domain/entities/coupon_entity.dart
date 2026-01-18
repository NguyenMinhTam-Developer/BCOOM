class CouponApplicabilityEntity {
  final bool canApply;
  final String reason;
  final num discountAmount;

  CouponApplicabilityEntity({
    required this.canApply,
    required this.reason,
    required this.discountAmount,
  });
}

class CouponCategoryEntity {
  final int id;
  final String name;
  final int? parentCategoryId;

  CouponCategoryEntity({
    required this.id,
    required this.name,
    this.parentCategoryId,
  });
}

class CouponBrandEntity {
  final int id;
  final String name;
  final String logo;

  CouponBrandEntity({
    required this.id,
    required this.name,
    required this.logo,
  });
}

class CouponProductEntity {
  final int id;
  final String name;
  final String code;

  CouponProductEntity({
    required this.id,
    required this.name,
    required this.code,
  });
}

class CouponSellerEntity {
  final int id;
  final String slug;
  final String name;
  final String logo;

  CouponSellerEntity({
    required this.id,
    required this.slug,
    required this.name,
    required this.logo,
  });
}

class CouponPromotionEntity {
  final int id;
  final String code;
  final String type;
  final String name;
  final String discountMethod;
  final String discountValue;
  final String discountCode;
  final String? minOrderValue;
  final String? maxDiscountAmount;
  final String endDate;
  final String applyType;
  final String? description;
  final String site;
  final List<CouponProductEntity> products;
  final List<CouponCategoryEntity> categories;
  final List<CouponBrandEntity> brands;
  final CouponSellerEntity? seller;

  CouponPromotionEntity({
    required this.id,
    required this.code,
    required this.type,
    required this.name,
    required this.discountMethod,
    required this.discountValue,
    required this.discountCode,
    this.minOrderValue,
    this.maxDiscountAmount,
    required this.endDate,
    required this.applyType,
    this.description,
    required this.site,
    required this.products,
    required this.categories,
    required this.brands,
    this.seller,
  });
}

class PlatformCouponEntity {
  final int id;
  final int promotionId;
  final String voucherCode;
  final String source;
  final CouponPromotionEntity promotion;
  final CouponApplicabilityEntity applicability;

  PlatformCouponEntity({
    required this.id,
    required this.promotionId,
    required this.voucherCode,
    required this.source,
    required this.promotion,
    required this.applicability,
  });
}

class SellerCouponEntity {
  final int id;
  final int? userVoucherId;
  final String voucherCode;
  final String source;
  final String? savedAt;
  final String? expiredAt;
  final CouponPromotionEntity promotion;
  final CouponApplicabilityEntity applicability;

  SellerCouponEntity({
    required this.id,
    this.userVoucherId,
    required this.voucherCode,
    required this.source,
    this.savedAt,
    this.expiredAt,
    required this.promotion,
    required this.applicability,
  });
}

class PlatformCouponsEntity {
  final List<PlatformCouponEntity> discountCode;
  final List<PlatformCouponEntity> freeShipping;

  PlatformCouponsEntity({
    required this.discountCode,
    required this.freeShipping,
  });
}

class SellerCouponsEntity {
  final List<SellerCouponEntity> discountCode;
  final List<SellerCouponEntity> freeShipping;

  SellerCouponsEntity({
    required this.discountCode,
    required this.freeShipping,
  });
}
