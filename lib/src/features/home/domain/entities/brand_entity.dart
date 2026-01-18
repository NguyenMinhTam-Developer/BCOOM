class BrandEntity {
  final int id;
  final String name;
  final String slug;
  final String? imageLocation;
  final String? imageUrl;
  final String? creator;

  const BrandEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.imageLocation,
    required this.imageUrl,
    required this.creator,
  });
}
