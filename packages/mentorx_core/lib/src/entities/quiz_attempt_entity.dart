part of 'package:mentorx_core/mentorx_core.dart';

enum QuizAttemptStatus { notStarted, inProgress, submitted, graded, abandoned }

class QuizAttemptEntity extends Equatable {
  final String id;
  final String quizId;
  final String? courseId;
  final String? courseName;
  final int attemptNumber;
  final QuizAttemptStatus status;
  final Map<String, String> answers;
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
    this.courseId,
    this.courseName,
    required this.attemptNumber,
    required this.status,
    this.answers = const {},
    required this.score,
    required this.totalMarks,
    required this.percentage,
    required this.passed,
    required this.startedAt,
    this.submittedAt,
    this.timeSpentSeconds = 0,
  });

  static final placeholder = QuizAttemptEntity(
    id: '',
    quizId: '',
    attemptNumber: 0,
    status: QuizAttemptStatus.inProgress,
    score: 0,
    totalMarks: 0,
    percentage: 0.0,
    passed: false,
    startedAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

  @override
  List<Object?> get props => [
        id,
        quizId,
        courseId,
        courseName,
        attemptNumber,
        status,
        answers,
        score,
        totalMarks,
        percentage,
        passed,
        startedAt,
        submittedAt,
        timeSpentSeconds,
      ];

  QuizAttemptEntity copyWith({
    String? id,
    String? quizId,
    String? courseId,
    String? courseName,
    int? attemptNumber,
    QuizAttemptStatus? status,
    Map<String, String>? answers,
    int? score,
    int? totalMarks,
    double? percentage,
    bool? passed,
    DateTime? startedAt,
    DateTime? submittedAt,
    int? timeSpentSeconds,
  }) {
    return QuizAttemptEntity(
      id: id ?? this.id,
      quizId: quizId ?? this.quizId,
      courseId: courseId ?? this.courseId,
      courseName: courseName ?? this.courseName,
      attemptNumber: attemptNumber ?? this.attemptNumber,
      status: status ?? this.status,
      answers: answers ?? this.answers,
      score: score ?? this.score,
      totalMarks: totalMarks ?? this.totalMarks,
      percentage: percentage ?? this.percentage,
      passed: passed ?? this.passed,
      startedAt: startedAt ?? this.startedAt,
      submittedAt: submittedAt ?? this.submittedAt,
      timeSpentSeconds: timeSpentSeconds ?? this.timeSpentSeconds,
    );
  }
}
