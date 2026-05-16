import 'package:mentorx_core/mentorx_core.dart';
import 'package:dio_course_repository/dio_course_repository.dart';

abstract final class StudentApplicationInfoModel {
  static StudentApplicationInfoEntity fromJson(Map<String, dynamic> json) {
    return StudentApplicationInfoEntity(
      requiredDocuments:
          (json['requiredDocuments'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      supportInfo: SupportInfoModel.fromJson(
        ModelParser.asMap(json['supportInfo']),
      ),
      steps:
          (json['steps'] as List<dynamic>?)
              ?.map((e) => RegistrationStepModel.fromJson(ModelParser.asMap(e)))
              .toList() ??
          [],
      grades:
          (json['grades'] as List<dynamic>?)
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
      categories: ModelParser.asList(
        json['categories'],
      ).map((e) => CategoryModel.fromJson(ModelParser.asMap(e))).toList(),
    );
  }
}

abstract final class AreaModel {
  static AreaEntity fromJson(Map<String, dynamic> json) {
    return AreaEntity(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? json['nameAr'] as String? ?? '',
      displayOrder: ModelParser.asInt(json['displayOrder']),
    );
  }
}

abstract final class GovernorateModel {
  static GovernorateEntity fromJson(Map<String, dynamic> json) {
    return GovernorateEntity(
      id: json['id']?.toString() ?? '',
      name: json['nameAr'] as String? ?? json['name'] as String? ?? '',
      areas: ModelParser.asList(
        json['areas'],
      ).map((e) => AreaModel.fromJson(ModelParser.asMap(e))).toList(),
    );
  }
}

abstract final class CenterModel {
  static CenterEntity fromJson(Map<String, dynamic> json) {
    return CenterEntity(
      id: ModelParser.asString(json['id']),
      name: ModelParser.asString(json['name']),
      governorate: _nullableString(json['governorate']),
      address: _nullableString(json['address']),
      phone: _nullableString(json['phone']),
      active: ModelParser.asBool(json['active'], fallback: true),
      whatsappGroupLink: _nullableString(json['whatsappGroupLink']),
      instagramLink: _nullableString(json['instagramLink']),
      facebookLink: _nullableString(json['facebookLink']),
      telegramLink: _nullableString(json['telegramLink']),
      youtubeLink: _nullableString(json['youtubeLink']),
      tiktokLink: _nullableString(json['tiktokLink']),
      latitude: _nullableDouble(json['latitude']),
      longitude: _nullableDouble(json['longitude']),
      createdAt: ModelParser.asDateTime(json['createdAt']),
    );
  }
}

String? _nullableString(dynamic value) {
  final s = ModelParser.asString(value);
  return s.isEmpty ? null : s;
}

double? _nullableDouble(dynamic value) {
  if (value == null) return null;
  return ModelParser.asDouble(value);
}
