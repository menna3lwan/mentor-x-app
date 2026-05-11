import 'package:mentorx_core/mentorx_core.dart';

abstract final class StudentApplicationInfoModel {
  static StudentApplicationInfoEntity fromJson(Map<String, dynamic> json) {
    return StudentApplicationInfoEntity(
      requiredDocuments: (json['requiredDocuments'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      supportInfo: SupportInfoModel.fromJson(
        ModelParser.asMap(json['supportInfo']),
      ),
      steps: (json['steps'] as List<dynamic>?)
              ?.map((e) => RegistrationStepModel.fromJson(ModelParser.asMap(e)))
              .toList() ??
          [],
      grades: (json['grades'] as List<dynamic>?)
              ?.map((e) => GradeModel.fromJson(ModelParser.asMap(e)))
              .toList() ??
          [],
    );
  }
}

abstract final class SupportInfoModel {
  static SupportInfoEntity fromJson(Map<String, dynamic> json) {
    return SupportInfoEntity(
      whatsapp: json['whatsapp'] as String? ?? '',
      email: json['email'] as String? ?? '',
      workingHours: json['workingHours'] as String? ?? '',
    );
  }
}

abstract final class RegistrationStepModel {
  static RegistrationStepEntity fromJson(Map<String, dynamic> json) {
    return RegistrationStepEntity(
      step: json['step']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }
}

abstract final class GradeModel {
  static GradeEntity fromJson(Map<String, dynamic> json) {
    return GradeEntity(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
    );
  }
}

abstract final class GovernorateModel {
  static GovernorateEntity fromJson(Map<String, dynamic> json) {
    return GovernorateEntity(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
    );
  }
}
