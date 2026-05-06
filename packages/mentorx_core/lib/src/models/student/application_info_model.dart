part of 'package:mentorx_core/mentorx_core.dart';

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
