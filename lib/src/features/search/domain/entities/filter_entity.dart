class FilterPivotEntity {
  final int productId;
  final int filterId;

  const FilterPivotEntity({
    required this.productId,
    required this.filterId,
  });
}

class FilterEntity {
  final int id;
  final String name;
  final String? creator;
  final FilterPivotEntity pivot;

  const FilterEntity({
    required this.id,
    required this.name,
    required this.creator,
    required this.pivot,
  });
}
