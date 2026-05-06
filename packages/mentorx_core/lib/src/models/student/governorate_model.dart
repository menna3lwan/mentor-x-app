part of 'package:mentorx_core/mentorx_core.dart';

abstract final class GovernorateModel {
  static GovernorateEntity fromJson(Map<String, dynamic> json) {
    return GovernorateEntity(
      id: json['id']?.toString() ?? json['name']?.toString() ?? '',
      name: json['name'] as String? ?? '',
    );
  }
}
