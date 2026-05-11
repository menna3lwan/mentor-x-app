import 'package:test/test.dart';
import 'package:dio_quiz_repository/dio_quiz_repository.dart';
import 'package:dio_http_client/dio_http_client.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'integration_config.dart';
import 'memory_cache_repository.dart';

final _log = MentorXLogger('QuizIntegrationTest');

void main() {
  late QuizRepository repository;
  late DioHttpClient httpClient;
  late MemoryCacheRepository cacheRepository;

  setUp(() async {
    MentorXLogger.enabled = true;
    cacheRepository = MemoryCacheRepository();
    httpClient = DioHttpClient(
      baseUrl: IntegrationConfig.baseUrl,
      cacheRepository: cacheRepository,
    );
    repository = DioQuizRepository(httpClient: httpClient);
  });

  group('Quiz Discovery & Integration', () {
    test('Get Quizzes (Discovery)', () async {
      try {
        final quizzes = await repository.getQuizzes();
        _log.info('Quizzes loaded: ${quizzes.length}');
        for (var quiz in quizzes.take(3)) {
          _log.info(' - ${quiz.title} (ID: ${quiz.id})');
        }
      } on QuizRepositoryException catch (e) {
        _log.error('Failed to load quizzes: ${e.code} - ${e.message}');
      } catch (e) {
        _log.error('Unexpected error: $e');
      }
    });

    test('Get Quiz Detail (Discovery)', () async {
      try {
        final detail = await repository.getQuiz('1');
        _log.info('Quiz 1 Detail: ${detail.title}');
      } on QuizRepositoryException catch (e) {
        _log.error('Failed to load detail: ${e.code} - ${e.message}');
      } catch (e) {
        _log.error('Unexpected error: $e');
      }
    });
  });
}
