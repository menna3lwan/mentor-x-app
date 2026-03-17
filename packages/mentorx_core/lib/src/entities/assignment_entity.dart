part of '../../mentorx_core.dart';

base class AssignmentEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final int totalMarks;
  final bool allowLateSubmission;
  final int? latePenaltyPercent;
  final List<String> attachmentUrls;
  final List<String> allowedFileTypes;
  final int maxFileSizeMb;
  final int maxFiles;

  const AssignmentEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.totalMarks,
    this.allowLateSubmission = false,
    this.latePenaltyPercent,
    this.attachmentUrls = const [],
    this.allowedFileTypes = const [],
    this.maxFileSizeMb = 10,
    this.maxFiles = 3,
  });

  bool get isOverdue => DateTime.now().isAfter(dueDate);


  static final placeholder = AssignmentEntity(
    id: '',
    title: '',
    description: '',
    dueDate: DateTime.fromMillisecondsSinceEpoch(0),
    totalMarks: 0,
  );
  @override
  List<Object?> get props => [
        id,
        title,
        description,
        dueDate,
        totalMarks,
        allowLateSubmission,
        latePenaltyPercent,
        attachmentUrls,
        allowedFileTypes,
        maxFileSizeMb,
        maxFiles,
      ];
}
