class SellerEntity {
  final int id;
  final String name;
  final String slug;
  final String imageUrl;
  final String imageLocation;
  final List<dynamic> industries;

  const SellerEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.imageUrl,
    required this.imageLocation,
    required this.industries,
  });
}

