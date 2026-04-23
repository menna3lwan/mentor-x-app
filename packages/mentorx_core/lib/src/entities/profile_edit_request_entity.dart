part of 'package:mentorx_core/mentorx_core.dart';

enum EditRequestStatus { pending, approved, rejected }

class ProfileEditRequestEntity extends Equatable {
  final String id;
  final String fieldName;
  final String oldValue;
  final String newValue;
  final String? reason;
  final EditRequestStatus status;
  final String? reviewNotes;
  final DateTime createdAt;

  const ProfileEditRequestEntity({
    required this.id,
    required this.fieldName,
    required this.oldValue,
    required this.newValue,
    required this.status,
    required this.createdAt,
    this.reason,
    this.reviewNotes,
  });

  static final placeholder = ProfileEditRequestEntity(
    id: '',
    fieldName: '',
    oldValue: '',
    newValue: '',
    status: EditRequestStatus.pending,
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

  @override
  List<Object?> get props => [
        id,
        fieldName,
        oldValue,
        newValue,
        reason,
        status,
        reviewNotes,
        createdAt,
      ];

  ProfileEditRequestEntity copyWith({
    String? id,
    String? fieldName,
    String? oldValue,
    String? newValue,
    String? reason,
    EditRequestStatus? status,
    String? reviewNotes,
    DateTime? createdAt,
  }) {
    return ProfileEditRequestEntity(
      id: id ?? this.id,
      fieldName: fieldName ?? this.fieldName,
      oldValue: oldValue ?? this.oldValue,
      newValue: newValue ?? this.newValue,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      reviewNotes: reviewNotes ?? this.reviewNotes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
