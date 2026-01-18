enum GiftStatus {
  active('Active'),
  used('Used'),
  expired('Expired');

  const GiftStatus(this.value);
  final String value;

  String toStringValue() => value;

  String get displayValue => switch (this) {
        active => 'Đang hiệu lực',
        used => 'Đã sử dụng',
        expired => 'Hết hạn',
      };

  static GiftStatus? fromString(String? value) {
    if (value == null) return null;
    return GiftStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => GiftStatus.active,
    );
  }
}

class MyGiftsEntity {
  final int id;
  final int userId;
  final String transactionId;
  final String voucherName;
  final String voucherLink;
  final num voucherPrice;
  final String voucherImage;
  final num pointsSpent;
  final GiftStatus status;
  final DateTime expiredAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userName;
  final String userPhone;

  const MyGiftsEntity({
    required this.id,
    required this.userId,
    required this.transactionId,
    required this.voucherName,
    required this.voucherLink,
    required this.voucherPrice,
    required this.voucherImage,
    required this.pointsSpent,
    required this.status,
    required this.expiredAt,
    required this.createdAt,
    required this.updatedAt,
    required this.userName,
    required this.userPhone,
  });
}
