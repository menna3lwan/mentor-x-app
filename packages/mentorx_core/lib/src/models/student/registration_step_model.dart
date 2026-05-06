part of 'package:mentorx_core/mentorx_core.dart';

abstract final class RegistrationStepModel {
  static RegistrationStepEntity fromJson(Map<String, dynamic> json) {
    return RegistrationStepEntity(
      step: json['step']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
    );
  }
}
