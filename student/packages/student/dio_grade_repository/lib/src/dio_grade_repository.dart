import 'package:mentorx_core/mentorx_core.dart';
import 'package:dio_quiz_repository/student_quiz_repository.dart';
import 'package:dio_assignment_repository/student_assignment_repository.dart';

final class DioGradeRepository
    extends HttpClientRepository<GradeRepositoryExceptionCode>
    implements GradeRepository {
  @override
  Never throwException(GradeRepositoryExceptionCode code, {String? message}) =>
      throw GradeRepositoryException(code: code, message: message);

  final HttpClient httpClient;

  DioGradeRepository({required this.httpClient});

  @override
  Future<List<QuizAttemptEntity>> getQuizGrades({
    String? courseId,
    int page = 1,
    int limit = 20,
  }) async {
    final response = await httpClient.get(
      '/api/student/grades/quizzes',
      queryParameters: {
        if (courseId != null) 'course_id': courseId,
        'page': page,
        'limit': limit,
      },
    );

    if (response.statusCode != 200) {
      throw GradeRepositoryException(
        code: GradeRepositoryExceptionCode.failedToLoadQuizResults,
        message: response.exception?.message,
      );
    }

    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return <QuizAttemptEntity>[
        for (final e in data)
          QuizAttemptModel.fromJson(e as Map<String, dynamic>),
      ];
    }
    return [];
  }

  @override
  Future<List<AssignmentSubmissionEntity>> getAssignmentGrades({
    String? courseId,
    int page = 1,
    int limit = 20,
  }) async {
    final response = await httpClient.get(
      '/api/student/grades/assignments',
      queryParameters: {
        if (courseId != null) 'course_id': courseId,
        'page': page,
        'limit': limit,
      },
    );

    if (response.statusCode != 200) {
      throw GradeRepositoryException(
        code: GradeRepositoryExceptionCode.failedToLoadAssignmentResults,
        message: response.exception?.message,
      );
    }

    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return <AssignmentSubmissionEntity>[
        for (final e in data)
          AssignmentSubmissionModel.fromJson(e as Map<String, dynamic>),
      ];
    }
    return [];
  }
}
