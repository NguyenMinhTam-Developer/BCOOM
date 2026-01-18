class ViewedProductEntity {
  final int id;
  final String name;
  final String code;
  final int priceMarket;
  final int priceSale;
  final double? rate;
  final String imageUrl;
  final String imageLocation;
  final int viewedNumber;
  final DateTime? viewedAt;

  const ViewedProductEntity({
    required this.id,
    required this.name,
    required this.code,
    required this.priceMarket,
    required this.priceSale,
    required this.rate,
    required this.imageUrl,
    required this.imageLocation,
    required this.viewedNumber,
    required this.viewedAt,
  });
}

