class FaqCategoryEntity {
  final int id;
  final String name;
  final String? description;
  final String imageView;

  FaqCategoryEntity({
    required this.id,
    required this.name,
    this.description,
    required this.imageView,
  });
}
