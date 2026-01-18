import 'package:intl/intl.dart';

/// Utility class for currency formatting operations
class CurrencyUtils {
  /// Private constructor to prevent instantiation
  CurrencyUtils._();

  /// Format a number as Vietnamese Dong (VND)
  ///
  /// Example:
  /// ```dart
  /// CurrencyUtils.formatVND(150000); // Returns "150.000 ₫"
  /// ```
  static String formatVND(num amount) {
    final formatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '₫',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  /// Format a number as Vietnamese Dong (VND) without the currency symbol
  ///
  /// Example:
  /// ```dart
  /// CurrencyUtils.formatVNDWithoutSymbol(150000); // Returns "150.000"
  /// ```
  static String formatVNDWithoutSymbol(num amount) {
    final formatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '',
      decimalDigits: 0,
    );
    return formatter.format(amount).trim();
  }

  /// Format a number as Vietnamese Dong (VND) with custom decimal digits
  ///
  /// Example:
  /// ```dart
  /// CurrencyUtils.formatVNDWithDecimals(150000.75, 2); // Returns "150.000,75 ₫"
  /// ```
  static String formatVNDWithDecimals(num amount, int decimalDigits) {
    final formatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '₫',
      decimalDigits: decimalDigits,
    );
    return formatter.format(amount);
  }

  /// Format a number as Vietnamese Dong (VND) with custom decimal digits
  ///
  /// Example:
  /// ```dart
  /// CurrencyUtils.formatVNDWithDecimals(150000.75, 2); // Returns "150.000,75 ₫"
  /// ```
  static String formatCurrentlyWithLocalText(num amount) {
    // If amount is less than or equal to 99,999, return full formatted string
    if (amount.abs() <= 99999) {
      final formatter = NumberFormat.currency(
        locale: 'vi_VN',
        symbol: '',
        decimalDigits: 0,
      );
      return formatter.format(amount);
    }

    // If amount is >= 1,000,000,000, use "T" (tỷ)
    if (amount.abs() >= 1000000000) {
      double tyValue = amount / 1000000000;
      String tyStr = tyValue.toStringAsFixed(tyValue.truncateToDouble() == tyValue ? 0 : 1);
      return '$tyStr T';
    }

    // If amount is >= 1,000,000, use "Tr" (triệu)
    if (amount.abs() >= 1000000) {
      double trValue = amount / 1000000;
      String trStr = trValue.toStringAsFixed(trValue.truncateToDouble() == trValue ? 0 : 1);
      return '$trStr Tr';
    }

    // If amount is >= 100,000, use "K"
    double kValue = amount / 1000;
    String kStr = kValue.toStringAsFixed(kValue.truncateToDouble() == kValue ? 0 : 1);
    return '$kStr K';
  }
}
