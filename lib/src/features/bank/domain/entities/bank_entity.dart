class BankEntity {
  final int id;
  final int customerId;
  final int bankId;
  final int bankBranchId;
  final String accountNumber;
  final String accountName;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final dynamic updatedBy;
  final String? bankName;
  final String? bankBranchName;
  final String? bankImageUrl;
  final String? bankImageLocation;

  BankEntity({
    required this.id,
    required this.customerId,
    required this.bankId,
    required this.bankBranchId,
    required this.accountNumber,
    required this.accountName,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.updatedBy,
    this.bankName,
    this.bankBranchName,
    this.bankImageUrl,
    this.bankImageLocation,
  });
}

class BankOptionEntity {
  final int id;
  final String name;
  final String imageUrl;
  final String imageLocation;

  BankOptionEntity({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.imageLocation,
  });
}

class BankListEntity {
  final List<BankEntity> banks;

  BankListEntity({
    required this.banks,
  });
}
