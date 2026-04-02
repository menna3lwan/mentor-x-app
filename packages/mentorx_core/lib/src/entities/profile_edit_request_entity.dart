part of '../../mentorx_core.dart';

enum EditRequestStatus { pending, approved, rejected }

base class ProfileEditRequestEntity extends Equatable {
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
}
