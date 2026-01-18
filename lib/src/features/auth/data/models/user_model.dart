import '../../../../core/constants/api_constants.dart';
import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.code,
    required super.fullName,
    required super.username,
    required super.phone,
    required super.email,
    required super.gender,
    required super.imageLocation,
    required super.imageUrl,
    required super.birthday,
    required super.countryId,
    required super.emailVerifiedAt,
    required super.status,
    required super.lastLogin,
    required super.createdAt,
    required super.updatedAt,
    required super.site,
    required super.objectId,
    required super.customerType,
    required super.identityCard,
    required super.identityCardAt,
    required super.avatar,
    required super.identityCardImageFrontLink,
    required super.identityCardImageBackLink,
    required super.licenseCode,
    required super.licenseImage,
    required super.provinceId,
    required super.districtId,
    required super.wardId,
    required super.address,
    required super.numberOfLessons,
    required super.numberOfGifts,
    required super.points,
    required super.isRegAkiya,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      code: JsonMapperUtils.safeParseStringNullable(json['code']),
      fullName: JsonMapperUtils.safeParseStringNullable(json['full_name']),
      username: JsonMapperUtils.safeParseStringNullable(json['username']),
      phone: JsonMapperUtils.safeParseStringNullable(json['phone']),
      email: JsonMapperUtils.safeParseStringNullable(json['email']),
      gender: JsonMapperUtils.safeParseStringNullable(json['gender']),
      imageLocation: JsonMapperUtils.safeParseStringNullable(json['image_location']),
      imageUrl: JsonMapperUtils.safeParseStringNullable(json['image_url']) ?? ApiConstants.baseUrl,
      birthday: JsonMapperUtils.safeParseDateTimeNullable(
        json['date_of_birth'] ?? json['birthday'],
      ),
      countryId: JsonMapperUtils.safeParseIntNullable(
        json['country_id'] ?? json['countryId'],
      ),
      emailVerifiedAt: JsonMapperUtils.safeParseDateTimeNullable(json['email_verified_at']),
      status: JsonMapperUtils.safeParseIntNullable(json['status']),
      lastLogin: JsonMapperUtils.safeParseDateTimeNullable(json['last_login']),
      createdAt: JsonMapperUtils.safeParseDateTimeNullable(json['created_at']),
      updatedAt: JsonMapperUtils.safeParseDateTimeNullable(json['updated_at']),
      site: JsonMapperUtils.safeParseStringNullable(json['site']),
      objectId: JsonMapperUtils.safeParseIntNullable(json['object_id']),
      customerType: JsonMapperUtils.safeParseStringNullable(json['customer_type']),
      identityCard: JsonMapperUtils.safeParseStringNullable(json['identity_card']),
      identityCardAt: JsonMapperUtils.safeParseDateTimeNullable(json['identity_card_at']),
      avatar: JsonMapperUtils.safeParseStringNullable(json['avatar']),
      identityCardImageFrontLink: JsonMapperUtils.safeParseStringNullable(json['identity_card_image_front_link']) ??
          JsonMapperUtils.safeParseStringNullable(json['identity_card_image_front']),
      identityCardImageBackLink: JsonMapperUtils.safeParseStringNullable(json['identity_card_image_back_link']) ??
          JsonMapperUtils.safeParseStringNullable(json['identity_card_image_back']),
      licenseCode: JsonMapperUtils.safeParseStringNullable(json['license_code']),
      licenseImage: JsonMapperUtils.safeParseStringNullable(json['license_image']),
      provinceId: JsonMapperUtils.safeParseIntNullable(json['province_id']),
      districtId: JsonMapperUtils.safeParseIntNullable(json['district_id']),
      wardId: JsonMapperUtils.safeParseIntNullable(json['ward_id']),
      address: JsonMapperUtils.safeParseStringNullable(json['address']),
      numberOfLessons: JsonMapperUtils.safeParseIntNullable(json['number_of_lessons']),
      numberOfGifts: JsonMapperUtils.safeParseIntNullable(json['number_of_gifts']),
      points: JsonMapperUtils.safeParseIntNullable(json['points']),
      isRegAkiya: JsonMapperUtils.safeParseBool(json['is_reg_akiya']),
    );
  }
}
