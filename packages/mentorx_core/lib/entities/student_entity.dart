part of '../mentorx_core.dart';

class StudentEntity extends Equatable {
  final String id;
  final String name;
  final String? email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String phoneNumber;
  final String? profileImageUrl;

  const StudentEntity({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
    this.email,
    this.profileImageUrl,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    createdAt,
    updatedAt,
    phoneNumber,
    profileImageUrl,
  ];

  StudentEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? profileImageUrl,
  }) {
    return StudentEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? profileImageUrl,
    );
  }
}
