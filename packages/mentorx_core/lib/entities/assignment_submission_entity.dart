part of '../mentorx_core.dart';

enum SubmissionStatus { submitted, graded, resubmitRequested }

final class AssignmentSubmissionEntity extends Equatable {
  final String id;
  final String assignmentId;
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

  @override
  List<Object?> get props => [
        id,
        assignmentId,
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
}
