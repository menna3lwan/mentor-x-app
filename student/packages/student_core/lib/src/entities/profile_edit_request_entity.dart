part of '../../student_core.dart';

enum EditRequestStatus { pending, approved, rejected }

final class ProfileEditRequestEntity extends Equatable {
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
}
