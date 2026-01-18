import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/bank_entity.dart';

class BankModel extends BankEntity {
  BankModel({
    required super.id,
    required super.customerId,
    required super.bankId,
    required super.bankBranchId,
    required super.accountNumber,
    required super.accountName,
    required super.isDefault,
    required super.createdAt,
    required super.updatedAt,
    super.deletedAt,
    super.updatedBy,
    super.bankName,
    super.bankBranchName,
    super.bankImageUrl,
    super.bankImageLocation,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      customerId: JsonMapperUtils.safeParseInt(json['customer_id']),
      bankId: JsonMapperUtils.safeParseInt(json['bank_id']),
      bankBranchId: JsonMapperUtils.safeParseInt(json['bank_branch_id']),
      accountNumber: JsonMapperUtils.safeParseString(json['account_number']),
      accountName: JsonMapperUtils.safeParseString(json['account_name']),
      isDefault: JsonMapperUtils.safeParseBool(json['is_default']),
      createdAt: JsonMapperUtils.safeParseDateTime(json['created_at']),
      updatedAt: JsonMapperUtils.safeParseDateTime(json['updated_at']),
      deletedAt: JsonMapperUtils.safeParseDateTimeNullable(json['deleted_at']),
      updatedBy: json['updated_by'],
      bankName: JsonMapperUtils.safeParseStringNullable(json['bank_name']),
      bankBranchName: JsonMapperUtils.safeParseStringNullable(json['bank_branch_name']),
      bankImageUrl: JsonMapperUtils.safeParseStringNullable(json['bank_image_url']),
      bankImageLocation: JsonMapperUtils.safeParseStringNullable(json['bank_image_location']),
    );
  }
}

class BankOptionModel extends BankOptionEntity {
  BankOptionModel({
    required super.id,
    required super.name,
    required super.imageUrl,
    required super.imageLocation,
  });

  factory BankOptionModel.fromJson(Map<String, dynamic> json) {
    return BankOptionModel(
      id: JsonMapperUtils.safeParseInt(json['id']),
      name: JsonMapperUtils.safeParseString(json['name']),
      imageUrl: JsonMapperUtils.safeParseString(json['image_url']),
      imageLocation: JsonMapperUtils.safeParseString(json['image_location']),
    );
  }
}

class BankListModel extends BankListEntity {
  BankListModel({
    required super.banks,
  });

  factory BankListModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    List<dynamic>? bankList;

    if (data is Map<String, dynamic>) {
      bankList = data['rows'];
    } else if (data is List) {
      bankList = data;
    } else {
      bankList = json['banks'];
    }

    return BankListModel(
      banks: JsonMapperUtils.safeParseList(
        bankList,
        mapper: (e) => BankModel.fromJson(
          JsonMapperUtils.safeParseMap(e),
        ),
      ),
    );
  }
}
