part of 'package:mentorx_core/mentorx_core.dart';

enum SubmissionStatus { pending, submitted, graded, late, rejected }


class AssignmentSubmissionEntity extends Equatable {
  final String id;
  final String assignmentId;
  final String? assignmentTitle;
  final String? courseName;
  final List<String> fileUrls;
  final String? notes;
  final int? score;
  final int? totalMarks;
  final String? feedback;
  final SubmissionStatus status;
  final bool isLate;
  final DateTime submittedAt;
  final DateTime? gradedAt;

  const AssignmentSubmissionEntity({
    required this.id,
    required this.assignmentId,
    this.assignmentTitle,
    this.courseName,
    required this.status,
    required this.submittedAt,
    this.fileUrls = const [],
    this.notes,
    this.score,
    this.totalMarks,
    this.feedback,
    this.isLate = false,
    this.gradedAt,
  });

  double? get percentage {
    if (score == null || totalMarks == null || totalMarks == 0) return null;
    return (score! / totalMarks!) * 100;
  }

  static final placeholder = AssignmentSubmissionEntity(
    id: '',
    assignmentId: '',
    status: SubmissionStatus.submitted,
    submittedAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

  @override
  List<Object?> get props => [
        id,
        assignmentId,
        assignmentTitle,
        courseName,
        fileUrls,
        notes,
        score,
        totalMarks,
        feedback,
        status,
        isLate,
        submittedAt,
        gradedAt,
      ];

  AssignmentSubmissionEntity copyWith({
    String? id,
    String? assignmentId,
    String? assignmentTitle,
    String? courseName,
    List<String>? fileUrls,
    String? notes,
    int? score,
    int? totalMarks,
    String? feedback,
    SubmissionStatus? status,
    bool? isLate,
    DateTime? submittedAt,
    DateTime? gradedAt,
  }) {
    return AssignmentSubmissionEntity(
      id: id ?? this.id,
      assignmentId: assignmentId ?? this.assignmentId,
      assignmentTitle: assignmentTitle ?? this.assignmentTitle,
      courseName: courseName ?? this.courseName,
      fileUrls: fileUrls ?? this.fileUrls,
      notes: notes ?? this.notes,
      score: score ?? this.score,
      totalMarks: totalMarks ?? this.totalMarks,
      feedback: feedback ?? this.feedback,
      status: status ?? this.status,
      isLate: isLate ?? this.isLate,
      submittedAt: submittedAt ?? this.submittedAt,
      gradedAt: gradedAt ?? this.gradedAt,
    );
  }
}
