part of 'package:mentorx_core/mentorx_core.dart';

enum ParentStatus { active, inactive, pending, suspended }

class ParentEntity extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String? email;
  final String phoneNumber;
  final String? profileImageUrl;
  final ParentStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int childrenCount;
  final double walletBalance;
  final int totalPoints;
  final Map<String, dynamic>? metadata;

  const ParentEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.email,
    required this.phoneNumber,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.profileImageUrl,
    this.childrenCount = 0,
    this.walletBalance = 0.0,
    this.totalPoints = 0,
    this.metadata,
  });

  String get fullName => '$firstName $lastName'.trim();

  static final placeholder = ParentEntity(
    id: '',
    firstName: '',
    lastName: '',
    phoneNumber: '',
    status: ParentStatus.pending,
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
    updatedAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        phoneNumber,
        profileImageUrl,
        status,
        childrenCount,
        walletBalance,
        totalPoints,
        metadata,
        createdAt,
        updatedAt,
      ];

  ParentEntity copyWith({
    String? id,
    String? firstName,
    String? lastName,
    MentorXNullableValue<String?>? email,
    String? phoneNumber,
    String? profileImageUrl,
    ParentStatus? status,
    int? childrenCount,
    double? walletBalance,
    int? totalPoints,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ParentEntity(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email != null ? email.value : this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      status: status ?? this.status,
      childrenCount: childrenCount ?? this.childrenCount,
      walletBalance: walletBalance ?? this.walletBalance,
      totalPoints: totalPoints ?? this.totalPoints,
      metadata: metadata ?? this.metadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
