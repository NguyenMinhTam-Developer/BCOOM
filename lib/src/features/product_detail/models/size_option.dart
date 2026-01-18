/// Represents a size option for a product variant
class SizeOption {
  final String id;
  final String label;
  final bool isAvailable;

  const SizeOption({
    required this.id,
    required this.label,
    this.isAvailable = true,
  });

  // Static sample data
  static List<SizeOption> get sampleSizes => [
        const SizeOption(id: '36', label: '36'),
        const SizeOption(id: '37', label: '37'),
        const SizeOption(id: '38', label: '38'),
        const SizeOption(id: '39', label: '39'),
        const SizeOption(id: '40', label: '40'),
        const SizeOption(id: '41', label: '41'),
        const SizeOption(id: '42', label: '42'),
        const SizeOption(id: '43', label: '43'),
        const SizeOption(id: '44', label: '44', isAvailable: false),
        const SizeOption(id: '45', label: '45', isAvailable: false),
      ];
}
