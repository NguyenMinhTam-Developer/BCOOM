class ProductImageEntity {
  final int id;
  final int productId;
  final String imageUrl;
  final String imageLocation;

  const ProductImageEntity({
    required this.id,
    required this.productId,
    required this.imageUrl,
    required this.imageLocation,
  });
}

