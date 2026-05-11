part of 'package:mentorx_core/mentorx_core.dart';

/// A utility class for robust JSON parsing across models.
final class ModelParser {
  ModelParser._();

  /// Converts dynamic value to `Map<String, dynamic>` safely
  static Map<String, dynamic> asMap(dynamic value) {
    if (value is Map<String, dynamic>) return value;
    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val));
    }
    return <String, dynamic>{};
  }

  /// Converts dynamic value to `List<dynamic>` safely
  static List<dynamic> asList(dynamic value) {
    if (value is List<dynamic>) return value;
    if (value is Map) {
      final d = value['data'] ?? value['items'] ?? value['content'];
      if (d is List<dynamic>) return d;
    }
    return <dynamic>[];
  }

  /// Safe cast to String or empty string
  static String asString(dynamic value, {String fallback = ''}) =>
      value?.toString() ?? fallback;

  /// Robust int parsing with fallback
  static int asInt(dynamic value, {int fallback = 0}) {
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? fallback;
    return fallback;
  }

  /// Robust double parsing with fallback
  static double asDouble(dynamic value, {double fallback = 0.0}) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? fallback;
    return fallback;
  }

  /// Robust bool parsing with fallback
  static bool asBool(dynamic value, {bool fallback = false}) {
    if (value == null) return fallback;
    if (value is bool) return value;
    if (value is String) {
      final v = value.toLowerCase();
      if (v == 'true' || v == '1') return true;
      if (v == 'false' || v == '0') return false;
    }
    if (value is int) {
      if (value == 1) return true;
      if (value == 0) return false;
    }
    return fallback;
  }

  /// Robust DateTime parsing
  static DateTime? asDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}
