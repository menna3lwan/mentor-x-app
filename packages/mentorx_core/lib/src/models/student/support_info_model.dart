part of 'package:mentorx_core/mentorx_core.dart';

abstract final class SupportInfoModel {
  static SupportInfoEntity fromJson(Map<String, dynamic> json) {
    return SupportInfoEntity(
      whatsapp: json['whatsapp'] as String? ?? '',
      email: json['email'] as String? ?? '',
      workingHours: json['workingHours'] as String? ?? '',
    );
  }
}
