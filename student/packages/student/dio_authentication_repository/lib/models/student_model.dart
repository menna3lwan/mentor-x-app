import 'package:mentorx_core/mentorx_core.dart';

final class StudentModel extends StudentEntity {
  const StudentModel({
    required super.id,
    required super.name,
    required super.phoneNumber,
    required super.createdAt,
    required super.updatedAt,
    super.email,
    super.profileImageUrl,
  });

  factory StudentModel.fromEntity(StudentEntity entity) {
    return StudentModel(
      id: entity.id,
      name: entity.name,
      phoneNumber: entity.phoneNumber,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      email: entity.email,
      profileImageUrl: entity.profileImageUrl,
    );
  }

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    final String firstName = json['firstName'] as String;
    final String lastName = json['lastName'] as String;
    final bool areBothNamesEmpty = firstName.isEmpty && lastName.isEmpty;
    final String name = areBothNamesEmpty ? '' : '$firstName $lastName';
    final String profileImage = (json['profileImage'] as String?) ?? '';
    return StudentModel(
      name: name,
      id: json['userId'] as String,
      phoneNumber: json['phone'] as String,
      profileImageUrl: profileImage.isEmpty ? null : profileImage,
      createdAt: _parseDateTime(json['createdAt']),
      updatedAt: _parseDateTime(json['updatedAt']),
    );
  }

  static DateTime _parseDateTime(String? dateTime) {
    return DateTime.tryParse(dateTime ?? '') ?? DateTime.now();
  }

  Map<String, dynamic> toJson() => {
    'userId': id,
    'firstName': name.split(' ').first,
    'lastName': name.split(' ').last,
    'phone': phoneNumber,
    'profileImage': profileImageUrl,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}
