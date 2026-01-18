extension CurrencyExtension on num {
  String? get toUsdCurrency {
    return '\$${toStringAsFixed(2)}';
  }
}
