import 'package:test/test.dart';
import 'package:dio_course_repository/dio_course_repository.dart';
import 'package:dio_http_client/dio_http_client.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'integration_config.dart';
import 'memory_cache_repository.dart';

void main() {
  late CourseRepository repository;
  late DioHttpClient httpClient;
  late MemoryCacheRepository cacheRepository;

  setUp(() async {
    cacheRepository = MemoryCacheRepository();
    httpClient = DioHttpClient(
      baseUrl: IntegrationConfig.baseUrl,
      cacheRepository: cacheRepository,
    );
    repository = DioCourseRepository(httpClient: httpClient);
  });

  group('Course Discovery Tests', () {
    test('Get All Courses', () async {
      try {
        final courses = await repository.getCourseCatalog();
        print('Courses count: ${courses.length}');
        for (var c in courses.take(5)) {
          print('Course: ${c.id} - ${c.title}');
        }
      } on HttpClientResponse catch (e) {
        print('Error: ${e.statusCode} ${e.data}');
      } catch (e) {
        print('Failed to get courses: $e');
      }
    });
  });
}
