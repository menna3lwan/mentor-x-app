import 'package:test/test.dart';
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
          phone: '1234567890',
        );

        verify(() => httpClient.post(
          '/api/student/register/start',
          data: {'phone': '1234567890'},
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

    group('completeRegistration', () {
      test('calls postMultipart with correct data and files', () async {
        registerFallbackValue(<String, List<String>>{});
        when(() => httpClient.postMultipart(
          any(),
          data: any(named: 'data'),
          files: any(named: 'files'),
        )).thenAnswer((_) async => const HttpClientResponse(
          data: {},
          statusCode: 200,
        ));

        await repository.completeRegistration(
          firstName: 'John',
          secondName: 'Doe',
          thirdName: 'Smith',
          fourthName: 'Brown',
          governorateId: '1',
          area: 'Maadi',
          gradeId: '1',
          online: true,
          otp: '123456',
          parentPhone: '01112345678',
          phone: '01012345678',
          password: 'password123',
          confirmPassword: 'password123',
          profileImagePath: 'path/to/profile.jpg',
        );

        verify(() => httpClient.postMultipart(
          '/api/student/register/complete',
          data: any(named: 'data'),
          files: {
            'profileImage': ['path/to/profile.jpg'],
          },
        )).called(1);
      });
    });

    group('getAreas', () {
      test('calls get with governorateId and returns list of strings', () async {
        when(() => httpClient.get('/api/student/register/areas/1')).thenAnswer(
          (_) async => const HttpClientResponse(
            data: ['Maadi', 'Nasr City'],
            statusCode: 200,
          ),
        );

        final result = await repository.getAreas('1');
        expect(result, ['Maadi', 'Nasr City']);
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
