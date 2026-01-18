/// Represents a recommended product item
class RecommendedProduct {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final bool isHot;
  final bool isFavorite;

  const RecommendedProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.isHot = false,
    this.isFavorite = false,
  });

  // Static sample data
  static List<RecommendedProduct> get sampleProducts => [
        const RecommendedProduct(
          id: '1',
          name: 'Balo gấu học sinh cấp 1 chống gù lưng',
          price: 150000,
          imageUrl: 'assets/images/products/product_thumbnail.png',
          isHot: true,
        ),
        const RecommendedProduct(
          id: '2',
          name: 'Balo gấu học sinh cấp 1 chống gù lưng',
          price: 150000,
          imageUrl: 'assets/images/products/product_thumbnail.png',
          isHot: true,
        ),
        const RecommendedProduct(
          id: '3',
          name: 'Túi đeo chéo thời trang nam nữ',
          price: 120000,
          imageUrl: 'assets/images/products/product_thumbnail.png',
          isHot: true,
        ),
        const RecommendedProduct(
          id: '4',
          name: 'Ví cầm tay da cao cấp',
          price: 250000,
          imageUrl: 'assets/images/products/product_thumbnail.png',
          isFavorite: true,
        ),
        const RecommendedProduct(
          id: '5',
          name: 'Mũ lưỡi trai thể thao',
          price: 85000,
          imageUrl: 'assets/images/products/product_thumbnail.png',
          isHot: true,
        ),
        const RecommendedProduct(
          id: '6',
          name: 'Kính mát thời trang unisex',
          price: 180000,
          imageUrl: 'assets/images/products/product_thumbnail.png',
        ),
      ];
}

