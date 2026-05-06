import 'package:test/test.dart';
import 'package:dio_student_registration_repository/dio_student_registration_repository.dart';
import 'package:dio_http_client/dio_http_client.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'integration_config.dart';
import 'memory_cache_repository.dart';


void main() {
  late StudentRegistrationRepository repository;
  late DioHttpClient httpClient;
  late MemoryCacheRepository cacheRepository;

  setUp(() async {
    MentorXLogger.enabled = true;
    cacheRepository = MemoryCacheRepository();
    httpClient = DioHttpClient(
      baseUrl: IntegrationConfig.baseUrl,
      cacheRepository: cacheRepository,
    );
    repository = DioStudentRegistrationRepository(httpClient: httpClient);
  });

  group('Registration Discovery Tests', () {
    test('Get Application Info', () async {
      try {
        final info = await repository.getApplicationInfo();
        print('Application Info Type: ${info.runtimeType}');
        print('Application Info: $info');
      } catch (e) {
        print('Failed to get application info: $e');
      }
    });

    test('Get Governorates', () async {
      try {
        final governorates = await repository.getGovernorates();
        print('Governorates count: ${governorates.length}');
        for (var g in governorates.take(3)) {
          print('Gov: ${g.name} (${g.id})');
        }
      } catch (e) {
        print('Failed to get governorates: $e');
      }
    });

    test('Get Areas for first governorate', () async {
      try {
        final governorates = await repository.getGovernorates();
        if (governorates.isNotEmpty) {
          final areas = await repository.getAreas(governorates.first.id);
          print('Areas for ${governorates.first.name}: ${areas.take(5)}');
        }
      } catch (e) {
        print('Failed to get areas: $e');
      }
    });

    test('Start Registration', () async {
      try {
        await repository.startRegistration(
          phone: '01234567899', // Dummy unique phone
        );
        print('Registration started successfully');
      } on HttpClientResponse catch (e) {
        print('Error: ${e.statusCode} ${e.data}');
      } catch (e) {
        print('Failed to start registration: $e');
      }
    });

    test('Complete Registration', () async {
      try {
        await repository.completeRegistration(
          firstName: 'Integration',
          secondName: 'Test',
          thirdName: 'User',
          fourthName: 'Entity',
          governorateId: 'اسيوط',
          area: 'اسيوط',
          gradeId: '1',
          online: true,
          otp: '123456', // Guessing
          parentPhone: '01234567888',
          phone: '01234567899',
          password: 'password123',
          confirmPassword: 'password123',
        );
        print('Registration completed successfully');
      } catch (e) {
        print('Failed to complete registration error: $e');
        if (e is StudentRegistrationException) {
          print('Exception code: ${e.code}');
          print('Exception message: ${e.message}');
        }
      }
    });
  });
}
