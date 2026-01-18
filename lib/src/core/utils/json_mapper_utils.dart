class JsonMapperUtils {
  static String? asString(dynamic data) {
    if (data is String) {
      return data;
    }
    return null;
  }

  static int? asInt(dynamic data) {
    if (data is int) {
      return data;
    }
    return null;
  }

  static double? asDouble(dynamic data) {
    if (data is double) {
      return data;
    }
    return null;
  }

  static bool? asBool(dynamic data) {
    if (data is bool) {
      return data;
    }
    return null;
  }

  static List<T>? asList<T>(dynamic data) {
    if (data is List) {
      return data.map((e) => e as T).toList();
    }
    return null;
  }

  static Map<String, dynamic>? asMap(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data;
    }
    return null;
  }

  /// Safely parse an integer value from JSON.
  /// Handles int, double, num, string, null, and empty values.
  /// Returns defaultValue if parsing fails.
  static int safeParseInt(dynamic data, {int defaultValue = 0}) {
    if (data == null) return defaultValue;
    if (data is int) return data;
    if (data is double) return data.toInt();
    if (data is num) return data.toInt();
    if (data is String) {
      if (data.isEmpty) return defaultValue;
      return int.tryParse(data) ?? defaultValue;
    }
    return defaultValue;
  }

  /// Safely parse a double value from JSON.
  /// Handles int, double, num, string, null, and empty values.
  /// Returns defaultValue if parsing fails.
  static double safeParseDouble(dynamic data, {double? defaultValue}) {
    if (data == null) return defaultValue ?? 0.0;
    if (data is double) return data;
    if (data is int) return data.toDouble();
    if (data is num) return data.toDouble();
    if (data is String) {
      if (data.isEmpty) return defaultValue ?? 0.0;
      return double.tryParse(data) ?? (defaultValue ?? 0.0);
    }
    return defaultValue ?? 0.0;
  }

  /// Safely parse a nullable double value from JSON.
  /// Handles int, double, num, string, null, and empty values.
  /// Returns null if parsing fails or value is null/empty.
  static double? safeParseDoubleNullable(dynamic data) {
    if (data == null) return null;
    if (data is double) return data;
    if (data is int) return data.toDouble();
    if (data is num) return data.toDouble();
    if (data is String) {
      if (data.isEmpty) return null;
      return double.tryParse(data);
    }
    return null;
  }

  /// Safely parse a nullable integer value from JSON.
  /// Handles int, double, num, string, null, and empty values.
  /// Returns null if parsing fails or value is null/empty.
  static int? safeParseIntNullable(dynamic data) {
    if (data == null) return null;
    if (data is int) return data;
    if (data is double) return data.toInt();
    if (data is num) return data.toInt();
    if (data is String) {
      if (data.isEmpty) return null;
      return int.tryParse(data);
    }
    return null;
  }

  /// Safely parse a string value from JSON.
  /// Handles String, null, and other types (converts to string).
  /// Returns defaultValue if parsing fails or value is null.
  static String safeParseString(dynamic data, {String defaultValue = ''}) {
    if (data == null) return defaultValue;
    if (data is String) return data;
    return data.toString();
  }

  /// Safely parse a nullable string value from JSON.
  /// Handles String, null, and other types (converts to string).
  /// Returns null if parsing fails or value is null.
  static String? safeParseStringNullable(dynamic data) {
    if (data == null) return null;
    if (data is String) return data.isEmpty ? null : data;
    final str = data.toString();
    return str.isEmpty ? null : str;
  }

  /// Safely parse a boolean value from JSON.
  /// Handles bool, int (0/1), string ('true'/'false'), null.
  /// Returns defaultValue if parsing fails.
  static bool safeParseBool(dynamic data, {bool defaultValue = false}) {
    if (data == null) return defaultValue;
    if (data is bool) return data;
    if (data is int) return data != 0;
    if (data is String) {
      final lower = data.toLowerCase().trim();
      if (lower == 'true' || lower == '1') return true;
      if (lower == 'false' || lower == '0' || lower.isEmpty) return false;
    }
    return defaultValue;
  }

  /// Safely parse a nullable boolean value from JSON.
  /// Handles bool, int (0/1), string ('true'/'false'), null.
  /// Returns null if parsing fails or value is null.
  static bool? safeParseBoolNullable(dynamic data) {
    if (data == null) return null;
    if (data is bool) return data;
    if (data is int) return data != 0;
    if (data is String) {
      final lower = data.toLowerCase().trim();
      if (lower == 'true' || lower == '1') return true;
      if (lower == 'false' || lower == '0' || lower.isEmpty) return false;
    }
    return null;
  }

  /// Safely parse a DateTime value from JSON.
  /// Handles String (ISO format), null.
  /// Returns defaultValue if parsing fails.
  static DateTime safeParseDateTime(dynamic data, {DateTime? defaultValue}) {
    if (data == null) return defaultValue ?? DateTime.now();
    if (data is DateTime) return data;
    if (data is String) {
      if (data.isEmpty) return defaultValue ?? DateTime.now();
      return DateTime.tryParse(data) ?? (defaultValue ?? DateTime.now());
    }
    return defaultValue ?? DateTime.now();
  }

  /// Safely parse a nullable DateTime value from JSON.
  /// Handles String (ISO format), null.
  /// Returns null if parsing fails or value is null/empty.
  static DateTime? safeParseDateTimeNullable(dynamic data) {
    if (data == null) return null;
    if (data is DateTime) return data;
    if (data is String) {
      if (data.isEmpty) return null;
      return DateTime.tryParse(data);
    }
    return null;
  }

  /// Safely parse a List value from JSON.
  /// Handles List, null.
  /// Returns defaultValue if parsing fails or value is null.
  static List<T> safeParseList<T>(
    dynamic data, {
    required T Function(dynamic) mapper,
    List<T> defaultValue = const [],
  }) {
    if (data == null) return defaultValue;
    if (data is List) {
      try {
        return data.map((e) => mapper(e)).toList();
      } catch (e) {
        return defaultValue;
      }
    }
    return defaultValue;
  }

  /// Safely parse a nullable List value from JSON.
  /// Handles List, null.
  /// Returns null if parsing fails or value is null.
  static List<T>? safeParseListNullable<T>(
    dynamic data, {
    required T Function(dynamic) mapper,
  }) {
    if (data == null) return null;
    if (data is List) {
      try {
        return data.map((e) => mapper(e)).toList();
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Safely parse a Map value from JSON.
  /// Handles Map(String, dynamic), null.
  /// Returns defaultValue if parsing fails or value is null.
  static Map<String, dynamic> safeParseMap(
    dynamic data, {
    Map<String, dynamic> defaultValue = const {},
  }) {
    if (data == null) return defaultValue;
    if (data is Map<String, dynamic>) return data;
    if (data is Map) {
      try {
        return Map<String, dynamic>.from(data);
      } catch (e) {
        return defaultValue;
      }
    }
    return defaultValue;
  }

  /// Safely parse a nullable Map value from JSON.
  /// Handles Map(String, dynamic), null.
  /// Returns null if parsing fails or value is null.
  static Map<String, dynamic>? safeParseMapNullable(dynamic data) {
    if (data == null) return null;
    if (data is Map<String, dynamic>) return data;
    if (data is Map) {
      try {
        return Map<String, dynamic>.from(data);
      } catch (e) {
        return null;
      }
    }
    return null;
  }
}
