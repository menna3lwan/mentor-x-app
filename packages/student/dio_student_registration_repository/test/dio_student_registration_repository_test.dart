import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:dio_student_registration_repository/dio_student_registration_repository.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient httpClient;
  late DioStudentRegistrationRepository repository;

  setUp(() {
    httpClient = MockHttpClient();
    repository = DioStudentRegistrationRepository(httpClient: httpClient);
    registerFallbackValue(<String, dynamic>{});
  });

  group('DioStudentRegistrationRepository', () {
    group('startRegistration', () {
      test('calls post and completes on success', () async {
        when(() => httpClient.post(
          '/api/student/register/start',
          data: any(named: 'data'),
        )).thenAnswer((_) async => const HttpClientResponse(
          data: {},
          statusCode: 200,
        ));

        await repository.startRegistration(
          firstName: 'John',
          phone: '1234567890',
          parentPhone: '0987654321',
        );

        verify(() => httpClient.post(
          '/api/student/register/start',
          data: any(named: 'data'),
        )).called(1);
      });
    });

    group('getGovernorates', () {
      test('returns list of GovernorateEntity on success', () async {
        final mockData = ['Cairo', 'Giza'];

        when(() => httpClient.get('/api/student/register/governorates')).thenAnswer(
          (_) async => HttpClientResponse(
            data: mockData,
            statusCode: 200,
          ),
        );

        final result = await repository.getGovernorates();
        expect(result.length, 2);
        expect(result[0].name, 'Cairo');
      });
    });

    group('checkPhone', () {
      test('returns true if phone is available', () async {
        when(() => httpClient.get('/api/student/register/check-phone/123')).thenAnswer(
          (_) async => const HttpClientResponse(
            data: {'available': true},
            statusCode: 200,
          ),
        );

        final result = await repository.checkPhone('123');
        expect(result, isTrue);
      });

      test('returns false if phone is taken (409)', () async {
        when(() => httpClient.get('/api/student/register/check-phone/123')).thenThrow(
          const HttpClientResponse(
            data: {},
            statusCode: 409,
          ),
        );

        final result = await repository.checkPhone('123');
        expect(result, isFalse);
      });
    });
  });
}
