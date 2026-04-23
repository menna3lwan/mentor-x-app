part of 'package:mentorx_core/mentorx_core.dart';

class AssignmentEntity extends Equatable {
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

  AssignmentEntity copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    int? totalMarks,
    bool? allowLateSubmission,
    int? latePenaltyPercent,
    List<String>? attachmentUrls,
    List<String>? allowedFileTypes,
    int? maxFileSizeMb,
    int? maxFiles,
  }) {
    return AssignmentEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      totalMarks: totalMarks ?? this.totalMarks,
      allowLateSubmission: allowLateSubmission ?? this.allowLateSubmission,
      latePenaltyPercent: latePenaltyPercent ?? this.latePenaltyPercent,
      attachmentUrls: attachmentUrls ?? this.attachmentUrls,
      allowedFileTypes: allowedFileTypes ?? this.allowedFileTypes,
      maxFileSizeMb: maxFileSizeMb ?? this.maxFileSizeMb,
      maxFiles: maxFiles ?? this.maxFiles,
    );
  }
}
