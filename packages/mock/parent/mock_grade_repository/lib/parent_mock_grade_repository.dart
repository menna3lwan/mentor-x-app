import 'package:mentorx_core/mentorx_core.dart';

final class MockParentGradeRepository implements ParentGradeRepository {
  final Duration delay;

  MockParentGradeRepository({
    this.delay = const Duration(milliseconds: 800),
  });

  @override
  Future<ParentGradeSummaryEntity> getGradeSummary(String childId) async {
    await Future.delayed(delay);
    return const ParentGradeSummaryEntity(
      overallAverage: 88.5,
      trend: 'up',
      trendChange: 2.5,
      totalAssessments: 12,
      graded: 10,
      pending: 2,
      passed: 9,
      failed: 1,
      distribution: {
        'excellent': 5,
        'veryGood': 3,
        'good': 1,
        'pass': 1,
      },
      byCourse: [
        ParentCourseGradeSummary(
          courseId: 'c1',
          courseTitle: 'Mathematics',
          average: 92.0,
          assessmentsCount: 4,
        ),
        ParentCourseGradeSummary(
          courseId: 'c2',
          courseTitle: 'Physics',
          average: 85.0,
          assessmentsCount: 3,
        ),
      ],
    );
  }

  @override
  Future<ParentGradeTrendEntity> getGradeTrend(String childId, {int months = 6}) async {
    await Future.delayed(delay);
    return const ParentGradeTrendEntity(
      months: [
        MonthlyGradeEntry(month: '2025-02', average: 82.0),
        MonthlyGradeEntry(month: '2025-03', average: 84.5),
        MonthlyGradeEntry(month: '2025-04', average: 86.0),
        MonthlyGradeEntry(month: '2025-05', average: 88.5),
      ],
    );
  }

  @override
  Future<List<QuizAttemptEntity>> getAssessments(
    String childId, {
    String? type,
    String? courseId,
  }) async {
    await Future.delayed(delay);
    return [
      QuizAttemptEntity(
        id: 'qa_1',
        quizId: 'q_math_midterm',
        courseId: 'c1',
        courseName: 'Mathematics',
        attemptNumber: 1,
        status: QuizAttemptStatus.submitted,
        score: 85,
        totalMarks: 100,
        percentage: 85.0,
        passed: true,
        startedAt: DateTime.now().subtract(const Duration(days: 15, hours: 2)),
        submittedAt: DateTime.now().subtract(const Duration(days: 15)),
      ),
      QuizAttemptEntity(
        id: 'qa_2',
        quizId: 'q_phys_quiz3',
        courseId: 'c2',
        courseName: 'Physics',
        attemptNumber: 1,
        status: QuizAttemptStatus.submitted,
        score: 42,
        totalMarks: 50,
        percentage: 84.0,
        passed: true,
        startedAt: DateTime.now().subtract(const Duration(days: 5, hours: 1)),
        submittedAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
    ];
  }
}
