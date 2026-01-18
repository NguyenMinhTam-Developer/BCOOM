class AddressEntity {
  final int id;
  final int customerId;
  final String? name;
  final String? phone;
  final String? street;
  final String? note;
  final num? lat;
  final num? lng;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final dynamic updatedBy;
  final AddressProvinceEntity? province;
  final AddressWardEntity? ward;

  AddressEntity({
    required this.id,
    required this.customerId,
    this.name,
    this.phone,
    this.street,
    this.note,
    this.lat,
    this.lng,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.updatedBy,
    this.province,
    this.ward,
  });
}

class AddressProvinceEntity {
  final String provinceCode;
  final String name;

  AddressProvinceEntity({
    required this.provinceCode,
    required this.name,
  });
}

class AddressWardEntity {
  final String wardCode;
  final String name;

  AddressWardEntity({
    required this.wardCode,
    required this.name,
  });
}

class AddressListEntity {
  final List<AddressEntity> addresses;

  AddressListEntity({
    required this.addresses,
  });
}
