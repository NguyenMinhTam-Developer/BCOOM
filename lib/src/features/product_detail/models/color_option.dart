import 'package:flutter/material.dart';

/// Represents a color option for a product variant
class ColorOption {
  final String id;
  final String name;
  final Color color;

  const ColorOption({
    required this.id,
    required this.name,
    required this.color,
  });

  // Static sample data
  static List<ColorOption> get sampleColors => [
        const ColorOption(id: '1', name: 'Trắng', color: Colors.white),
        const ColorOption(id: '2', name: 'Xanh nhạt', color: Color(0xFF87CEEB)),
        const ColorOption(id: '3', name: 'Xanh dương', color: Color(0xFF1E3A5F)),
        const ColorOption(id: '4', name: 'Xanh đậm', color: Color(0xFF0D1B2A)),
        const ColorOption(id: '5', name: 'Đen', color: Color(0xFF1A1A2E)),
        const ColorOption(id: '6', name: 'Xám', color: Color(0xFF6B7280)),
        const ColorOption(id: '7', name: 'Hồng', color: Color(0xFFE0004D)),
        const ColorOption(id: '8', name: 'Đỏ', color: Color(0xFFE10600)),
        const ColorOption(id: '9', name: 'Cam', color: Color(0xFFFA4616)),
        const ColorOption(id: '10', name: 'Vàng', color: Color(0xFFFFC107)),
        const ColorOption(id: '11', name: 'Xanh lá', color: Color(0xFF4CAF50)),
        const ColorOption(id: '12', name: 'Tím', color: Color(0xFF9C27B0)),
      ];
}

