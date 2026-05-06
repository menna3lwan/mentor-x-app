part of 'package:mentorx_core/mentorx_core.dart';

abstract final class GradeModel {
  static GradeEntity fromJson(Map<String, dynamic> json) {
    return GradeEntity(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
    );
  }
}
