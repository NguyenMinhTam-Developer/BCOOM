import 'color_option.dart';
import 'size_option.dart';

/// Represents a product with full details
class Product {
  final String id;
  final String name;
  final String sku;
  final double price;
  final String? originalPrice;
  final String description;
  final String categoryName;
  final String brand;
  final String supplier;
  final String productLink;
  final List<String> images;
  final List<ColorOption> colors;
  final List<SizeOption> sizes;
  final bool isFavorite;

  const Product({
    required this.id,
    required this.name,
    required this.sku,
    required this.price,
    this.originalPrice,
    required this.description,
    required this.categoryName,
    required this.brand,
    required this.supplier,
    required this.productLink,
    required this.images,
    required this.colors,
    required this.sizes,
    this.isFavorite = false,
  });

  /// Formats price to Vietnamese currency format
  String get formattedPrice {
    final priceString = price.toStringAsFixed(0);
    final buffer = StringBuffer();
    int count = 0;
    for (int i = priceString.length - 1; i >= 0; i--) {
      buffer.write(priceString[i]);
      count++;
      if (count % 3 == 0 && i != 0) {
        buffer.write('.');
      }
    }
    return '${buffer.toString().split('').reversed.join()}đ';
  }

  // Static sample data
  static Product get sampleProduct => Product(
        id: '1',
        name: 'Max Health Flex Joint – Đặc Trị Xương Khớp',
        sku: 'FAMALYB22002',
        price: 699000,
        description: '''Giới thiệu Thạch dứa giảm cân chính hãng Matxi Corp ( cam kết không giảm hoàn tiền sau 1 liệu trình).
Thạch dứa chính hãng Matxi Corp %. Phát hiện hàng giả đền gấp 10 lần...Giới thiệu Thạch dứa giảm cân chính hãng Matxi Corp ( cam kết không giảm hoàn tiền sau 1 liệu trình)
Thạch dứa chính hãng Matxi Corp %. Phát hiện hàng giả đền gấp 10 lần...Giới thiệu Thạch dứa giảm cân chính hãng Matxi Corp ( cam kết không giảm hoàn tiền sau 1 liệu trình)
Thạch dứa chính hãng Matxi Corp %. Phát hiện hàng giả đền gấp 10 lần...

Công dụng:
- Hỗ trợ giảm cân an toàn hiệu quả
- Thanh lọc cơ thể, đào thải độc tố
- Cải thiện hệ tiêu hóa
- Giúp da sáng mịn, trẻ trung hơn

Thành phần:
- Chiết xuất dứa tự nhiên
- Vitamin C, E
- Các khoáng chất thiết yếu

Hướng dẫn sử dụng:
- Dùng 1 gói/ngày sau bữa ăn
- Kết hợp chế độ ăn uống lành mạnh
- Uống đủ nước mỗi ngày''',
        categoryName: 'Thực phẩm chức năng',
        brand: 'Matxi',
        supplier: 'Matxi Corp',
        productLink: 'http://one5.mango.com/vn/women-sneakers-nike-air-max-270-react-v2-lunar-yellow-pink-white-dQ1132-100.html',
        images: List.generate(12, (_) => 'assets/images/products/product_thumbnail.png'),
        colors: ColorOption.sampleColors,
        sizes: SizeOption.sampleSizes,
      );
}
