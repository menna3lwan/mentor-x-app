part of 'package:mentorx_core/mentorx_core.dart';

enum ParentChildLinkStatus { pending, linked, rejected, unlinked }

class ParentChildEntity extends Equatable {
  final String id;
  final String name;
  final String? studentCode;
  final String? profileImageUrl;
  final String? gradeName;
  final String? centerName;
  final bool? isVerified;

  const ParentChildEntity({
    required this.id,
    required this.name,
    this.studentCode,
    this.profileImageUrl,
    this.gradeName,
    this.centerName,
    this.isVerified,
  });

  static const placeholder = ParentChildEntity(id: '', name: '');

  @override
  List<Object?> get props => [
    id,
    name,
    studentCode,
    profileImageUrl,
    gradeName,
    centerName,
    isVerified,
  ];

  ParentChildEntity copyWith({
    String? id,
    String? name,
    String? studentCode,
    String? profileImageUrl,
    String? gradeName,
    String? centerName,
    bool? isVerified,
  }) {
    return ParentChildEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      studentCode: studentCode ?? this.studentCode,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      gradeName: gradeName ?? this.gradeName,
      centerName: centerName ?? this.centerName,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}
