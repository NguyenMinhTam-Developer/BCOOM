import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/my_gifts.dart';

class MyGiftsModel extends MyGiftsEntity {
  const MyGiftsModel({
    required super.id,
    required super.userId,
    required super.transactionId,
    required super.voucherName,
    required super.voucherLink,
    required super.voucherPrice,
    required super.voucherImage,
    required super.pointsSpent,
    required super.status,
    required super.expiredAt,
    required super.createdAt,
    required super.updatedAt,
    required super.userName,
    required super.userPhone,
  });

  factory MyGiftsModel.fromJson(Map<String, dynamic> json) {
    return MyGiftsModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      userId: JsonMapperUtils.safeParseInt(json['user_id']),
      transactionId: JsonMapperUtils.safeParseString(json['transaction_id']),
      voucherName: JsonMapperUtils.safeParseString(json['voucher_name']),
      voucherLink: JsonMapperUtils.safeParseString(json['voucher_link']),
      voucherPrice: JsonMapperUtils.safeParseInt(json['voucher_price']),
      voucherImage: JsonMapperUtils.safeParseString(json['voucher_image']),
      pointsSpent: JsonMapperUtils.safeParseInt(json['points_spent']),
      status: GiftStatus.fromString(JsonMapperUtils.safeParseStringNullable(json['status'])) ?? GiftStatus.active,
      expiredAt: JsonMapperUtils.safeParseDateTime(
        json['expired_at'],
        defaultValue: DateTime.now(),
      ),
      createdAt: JsonMapperUtils.safeParseDateTime(
        json['created_at'],
        defaultValue: DateTime.now(),
      ),
      updatedAt: JsonMapperUtils.safeParseDateTime(
        json['updated_at'],
        defaultValue: DateTime.now(),
      ),
      userName: JsonMapperUtils.safeParseString(json['user_name']),
      userPhone: JsonMapperUtils.safeParseString(json['user_phone']),
    );
  }
}
