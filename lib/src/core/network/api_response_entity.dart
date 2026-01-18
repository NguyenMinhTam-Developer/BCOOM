class ApiResponseEntity<T> {
  final String status;
  final String description;
  final T data;

  const ApiResponseEntity({
    required this.status,
    required this.description,
    required this.data,
  });
}
