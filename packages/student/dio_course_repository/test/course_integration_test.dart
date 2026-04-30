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

  group('Course Discovery & Integration', () {
    test('Get Course Catalog (Discovery)', () async {
      try {
        final catalog = await repository.getCourseCatalog();
        print('Catalog loaded: ${catalog.length} courses');
        for (var course in catalog.take(3)) {
          print(' - ${course.title} (ID: ${course.id})');
        }
      } on CourseRepositoryException catch (e) {
        print('Failed to load catalog: ${e.code} - ${e.message}');
      } catch (e) {
        print('Unexpected error: $e');
      }
    });

    test('Get Categories (Discovery)', () async {
      try {
        final categories = await repository.getCategories();
        print('Categories loaded: ${categories.length}');
        for (var cat in categories.take(5)) {
          print(' - ${cat.name} (ID: ${cat.id})');
        }
      } on CourseRepositoryException catch (e) {
        print('Failed to load categories: ${e.code} - ${e.message}');
      } catch (e) {
        print('Unexpected error: $e');
      }
    });

    test('Get Course Detail (Discovery)', () async {
      // Trying ID 1 just in case
      try {
        final detail = await repository.getCourseDetail('1');
        print('Course 1 Detail: ${detail.title}');
      } on CourseRepositoryException catch (e) {
        print('Failed to load detail: ${e.code} - ${e.message}');
      } catch (e) {
        print('Unexpected error: $e');
      }
    });
  });
}
