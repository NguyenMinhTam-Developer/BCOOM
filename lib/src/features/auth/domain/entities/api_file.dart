class ApiFileEntity {
  final String type;
  final String fileName;
  final String name;
  final num size;
  final String? linkView;

  ApiFileEntity({
    required this.type,
    required this.fileName,
    required this.name,
    required this.size,
    this.linkView,
  });
}
