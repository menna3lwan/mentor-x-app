part of '../mentorx_core.dart';

enum QuizAttemptStatus { inProgress, submitted, timedOut }

final class QuizAttemptEntity extends Equatable {
  final String id;
  final String quizId;
  final int attemptNumber;
  final QuizAttemptStatus status;
  final int score;
  final int totalMarks;
  final double percentage;
  final bool passed;
  final DateTime startedAt;
  final DateTime? submittedAt;
  final int timeSpentSeconds;

  const QuizAttemptEntity({
    required this.id,
    required this.quizId,
    required this.attemptNumber,
    required this.status,
    required this.score,
    required this.totalMarks,
    required this.percentage,
    required this.passed,
    required this.startedAt,
    this.submittedAt,
    this.timeSpentSeconds = 0,
  });

  @override
  List<Object?> get props => [
        id,
        quizId,
        attemptNumber,
        status,
        score,
        totalMarks,
        percentage,
        passed,
        startedAt,
        submittedAt,
        timeSpentSeconds,
      ];
}
