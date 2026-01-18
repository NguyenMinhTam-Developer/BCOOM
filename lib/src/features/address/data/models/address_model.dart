import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  AddressModel({
    required super.id,
    required super.customerId,
    super.name,
    super.phone,
    super.street,
    super.note,
    super.lat,
    super.lng,
    required super.isDefault,
    required super.createdAt,
    required super.updatedAt,
    super.deletedAt,
    super.updatedBy,
    super.province,
    super.ward,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      customerId: JsonMapperUtils.safeParseInt(json['customer_id']),
      name: JsonMapperUtils.safeParseStringNullable(json['name']),
      phone: JsonMapperUtils.safeParseStringNullable(json['phone']),
      street: JsonMapperUtils.safeParseStringNullable(json['street']),
      note: JsonMapperUtils.safeParseStringNullable(json['note']),
      lat: JsonMapperUtils.safeParseDoubleNullable(json['lat']),
      lng: JsonMapperUtils.safeParseDoubleNullable(json['lng']),
      isDefault: JsonMapperUtils.safeParseBool(json['is_default']),
      createdAt: JsonMapperUtils.safeParseDateTime(json['created_at']),
      updatedAt: JsonMapperUtils.safeParseDateTime(json['updated_at']),
      deletedAt: JsonMapperUtils.safeParseDateTimeNullable(json['deleted_at']),
      updatedBy: json['updated_by'],
      province: json['province'] != null
          ? AddressProvinceModel.fromJson(
              JsonMapperUtils.safeParseMap(json['province']),
            )
          : null,
      ward: json['ward'] != null
          ? AddressWardModel.fromJson(
              JsonMapperUtils.safeParseMap(json['ward']),
            )
          : null,
    );
  }
}

class AddressProvinceModel extends AddressProvinceEntity {
  AddressProvinceModel({
    required super.provinceCode,
    required super.name,
  });

  factory AddressProvinceModel.fromJson(Map<String, dynamic> json) {
    return AddressProvinceModel(
      provinceCode: JsonMapperUtils.safeParseString(json['province_code']),
      name: JsonMapperUtils.safeParseString(json['name']),
    );
  }
}

class AddressWardModel extends AddressWardEntity {
  AddressWardModel({
    required super.wardCode,
    required super.name,
  });

  factory AddressWardModel.fromJson(Map<String, dynamic> json) {
    return AddressWardModel(
      wardCode: JsonMapperUtils.safeParseString(json['ward_code']),
      name: JsonMapperUtils.safeParseString(json['name']),
    );
  }
}

class AddressListModel extends AddressListEntity {
  AddressListModel({
    required super.addresses,
  });

  factory AddressListModel.fromJson(Map<String, dynamic> json) {
    // Response structure: { "status": "success", "data": [...] }
    // data is directly an array of address objects
    final data = json['data'];
    List<dynamic>? addressList;

    if (data is List) {
      // data is directly a list of addresses
      addressList = data;
    } else if (data is Map<String, dynamic>) {
      // If data is an object, check for 'results' key (paginated response)
      addressList = data['results'];
    } else {
      // Fallback to 'addresses' key
      addressList = json['addresses'];
    }

    return AddressListModel(
      addresses: JsonMapperUtils.safeParseList(
        addressList,
        mapper: (e) => AddressModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
    );
  }
}
