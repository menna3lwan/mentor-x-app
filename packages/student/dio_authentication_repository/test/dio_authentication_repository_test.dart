import 'package:dio_authentication_repository/dio_authentication_repository.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements HttpClient {}
class MockCacheRepository extends Mock implements CacheRepository {}

void main() {
  late MockHttpClient httpClient;
  late MockCacheRepository cacheRepository;
  late DioAuthenticationRepository repository;

  setUp(() {
    httpClient = MockHttpClient();
    cacheRepository = MockCacheRepository();
    repository = DioAuthenticationRepository(
      httpClient: httpClient,
      cacheRepository: cacheRepository,
    );
    
    registerFallbackValue(Uri());
  });

  group('DioAuthenticationRepository', () {
    const tPhone = '0123456789';
    const tOtp = '123456';
    const tStudentData = {
      'id': '1',
      'name': 'Test Student',
      'email': 'test@example.com',
      'phone': tPhone,
    };

    group('sendOtp', () {
      test('should call httpClient.post and return true on success', () async {
        // arrange
        when(() => httpClient.post(
              '/api/student/register/start',
              data: any(named: 'data'),
            )).thenAnswer((_) async => const HttpClientResponse(
              data: {'data': {'otp_expires_in_seconds': 60, 'otp_length': 6}},
              statusCode: 200,
            ));

        // act
        final result = await repository.sendOtp(tPhone);

        // assert
        expect(result?.otpDuration?.inSeconds, 60);
        verify(() => httpClient.post(
              '/api/student/register/start',
              data: {'phone': tPhone},
            )).called(1);
      });

      test('should throw AuthenticationRepositoryException on failure', () async {
        // arrange
        when(() => httpClient.post(
              any(),
              data: any(named: 'data'),
            )).thenAnswer((_) async => const HttpClientResponse(
              data: {'message': 'Error'},
              statusCode: 400,
            ));

        // act & assert
        expect(
          () => repository.sendOtp(tPhone),
          throwsA(isA<AuthenticationRepositoryException>()),
        );
      });
    });

    group('verifyOtp', () {
      test('should call httpClient.post and return StudentEntity on success', () async {
        // arrange
        when(() => httpClient.post(
              '/api/student/register/start',
              data: any(named: 'data'),
            )).thenAnswer((_) async => const HttpClientResponse(
              data: {'data': {'otp_expires_in_seconds': 60, 'otp_length': 6}},
              statusCode: 200,
            ));
        
        when(() => httpClient.post(
              '/api/student/register/complete',
              data: any(named: 'data'),
            )).thenAnswer((_) async => const HttpClientResponse(
              data: {'data': tStudentData},
              statusCode: 200,
            ));

        await repository.sendOtp(tPhone);

        // act
        final result = await repository.verifyOtp(tOtp);

        // assert
        expect(result.id, '1');
        expect(result.name, 'Test Student');
        verify(() => httpClient.post(
              '/api/student/register/complete',
              data: {'phone': tPhone, 'otp': tOtp},
            )).called(1);
      });
    });

    group('signOut', () {
      test('should call httpClient.post and return normally', () async {
        // arrange
        when(() => httpClient.post(
              '/api/auth/student/logout',
            )).thenAnswer((_) async => const HttpClientResponse(
              data: {},
              statusCode: 200,
            ));
        when(() => cacheRepository.remove(any())).thenAnswer((_) async {});

        // act & assert
        await expectLater(repository.signOut(), completes);
        verify(() => httpClient.post('/api/auth/student/logout')).called(1);
      });
    });

    group('getCurrentUser', () {
      test('should call httpClient.get and return StudentEntity on success', () async {
        // arrange
        when(() => httpClient.isAuthenticated()).thenAnswer((_) async => true);
        when(() => httpClient.get(
              '/api/auth/student/me',
            )).thenAnswer((_) async => const HttpClientResponse(
              data: {'data': tStudentData},
              statusCode: 200,
            ));
        when(() => cacheRepository.put(any(), any())).thenAnswer((_) async {});

        // act
        final result = await repository.getCurrentUser();

        // assert
        expect(result?.id, '1');
        verify(() => httpClient.get('/api/auth/student/me')).called(1);
      });

      test('should return null when status code is 401', () async {
        // arrange
        when(() => httpClient.isAuthenticated()).thenAnswer((_) async => true);
        when(() => httpClient.get(
              any(),
            )).thenAnswer((_) async => const HttpClientResponse(
              data: {},
              statusCode: 401,
            ));

        // act
        final result = await repository.getCurrentUser();

        // assert
        expect(result, isNull);
      });
    });
  });
}
