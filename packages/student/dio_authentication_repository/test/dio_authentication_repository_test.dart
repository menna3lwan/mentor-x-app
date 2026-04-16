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
        when(
          () => httpClient.post(
            '/api/student/register/start',
            data: any(named: 'data'),
          ),
        ).thenAnswer(
          (_) async => const HttpClientResponse(
            data: {
              'data': {'otp_expires_in_seconds': 60, 'otp_length': 6},
            },
            statusCode: 200,
          ),
        );

        // act
        final result = await repository.sendOtp(tPhone);

        // assert
        expect(result?.otpDuration?.inSeconds, 60);
        verify(
          () => httpClient.post(
            '/api/student/register/start',
            data: {'phone': tPhone},
          ),
        ).called(1);
      });

      test(
        'should throw AuthenticationRepositoryException on failure',
        () async {
          // arrange
          when(
            () => httpClient.post(any(), data: any(named: 'data')),
          ).thenAnswer(
            (_) async => const HttpClientResponse(
              data: {'message': 'Error'},
              statusCode: 400,
            ),
          );

          // act & assert
          expect(
            () => repository.sendOtp(tPhone),
            throwsA(isA<AuthenticationRepositoryException>()),
          );
        },
      );
    });

    group('requestPasswordReset', () {
      test(
        'should call v1 forgot-password endpoint and complete on success',
        () async {
          when(
            () => httpClient.post(
              '/api/v1/auth/forgot-password',
              data: {'phone': tPhone},
            ),
          ).thenAnswer(
            (_) async => const HttpClientResponse(data: {}, statusCode: 200),
          );

          await expectLater(repository.requestPasswordReset(tPhone), completes);

          verify(
            () => httpClient.post(
              '/api/v1/auth/forgot-password',
              data: {'phone': tPhone},
            ),
          ).called(1);
        },
      );

      test(
        'should fallback to legacy endpoint when v1 endpoint is missing',
        () async {
          when(
            () => httpClient.post(
              '/api/v1/auth/forgot-password',
              data: {'phone': tPhone},
            ),
          ).thenThrow(
            HttpClientResponse(
              data: {'message': 'not found'},
              statusCode: 404,
              exception: HttpClientException(
                code: HttpClientExceptionCode.notFound,
                message: 'not found',
              ),
            ),
          );
          when(
            () => httpClient.post(
              '/api/auth/forgot-password',
              data: {'phone': tPhone},
            ),
          ).thenAnswer(
            (_) async => const HttpClientResponse(data: {}, statusCode: 204),
          );

          await expectLater(repository.requestPasswordReset(tPhone), completes);

          verify(
            () => httpClient.post(
              '/api/v1/auth/forgot-password',
              data: {'phone': tPhone},
            ),
          ).called(1);
          verify(
            () => httpClient.post(
              '/api/auth/forgot-password',
              data: {'phone': tPhone},
            ),
          ).called(1);
        },
      );

      test(
        'should throw AuthenticationRepositoryException on backend failure',
        () async {
          when(
            () => httpClient.post(
              '/api/v1/auth/forgot-password',
              data: {'phone': tPhone},
            ),
          ).thenThrow(
            HttpClientResponse(
              data: {'message': 'server error'},
              statusCode: 500,
              exception: HttpClientException(
                code: HttpClientExceptionCode.serverError,
                message: 'server error',
              ),
            ),
          );

          expect(
            () => repository.requestPasswordReset(tPhone),
            throwsA(
              isA<AuthenticationRepositoryException>().having(
                (e) => e.code,
                'code',
                AuthenticationRepositoryExceptionCode
                    .failedToRequestPasswordReset,
              ),
            ),
          );
        },
      );
    });

    group('resetPassword', () {
      test(
        'should call reset-password endpoint and complete on success',
        () async {
          when(
            () => httpClient.post(
              '/api/v1/auth/reset-password',
              data: {
                'phone': tPhone,
                'otp': tOtp,
                'new_password': 'Secure@Pass1',
              },
            ),
          ).thenAnswer(
            (_) async => const HttpClientResponse(data: {}, statusCode: 200),
          );

          await expectLater(
            repository.resetPassword(
              phoneNumber: tPhone,
              otp: tOtp,
              newPassword: 'Secure@Pass1',
            ),
            completes,
          );
        },
      );

      test('should throw failedToResetPassword on backend errors', () async {
        when(
          () => httpClient.post(
            '/api/v1/auth/reset-password',
            data: {
              'phone': tPhone,
              'otp': tOtp,
              'new_password': 'Secure@Pass1',
            },
          ),
        ).thenThrow(
          HttpClientResponse(
            data: {'message': 'invalid otp'},
            statusCode: 400,
            exception: HttpClientException(
              code: HttpClientExceptionCode.badResponse,
              message: 'invalid otp',
            ),
          ),
        );
        when(
          () => httpClient.post(
            '/api/v1/auth/reset-password',
            data: {
              'phone': tPhone,
              'otp_code': tOtp,
              'password': 'Secure@Pass1',
            },
          ),
        ).thenThrow(
          HttpClientResponse(
            data: {'message': 'invalid otp'},
            statusCode: 400,
            exception: HttpClientException(
              code: HttpClientExceptionCode.badResponse,
              message: 'invalid otp',
            ),
          ),
        );

        expect(
          () => repository.resetPassword(
            phoneNumber: tPhone,
            otp: tOtp,
            newPassword: 'Secure@Pass1',
          ),
          throwsA(
            isA<AuthenticationRepositoryException>().having(
              (e) => e.code,
              'code',
              AuthenticationRepositoryExceptionCode.failedToResetPassword,
            ),
          ),
        );
      });
    });

    group('verifyOtp', () {
      test(
        'should call httpClient.post and return StudentEntity on success',
        () async {
          // arrange
          when(
            () => httpClient.post(
              '/api/student/register/start',
              data: any(named: 'data'),
            ),
          ).thenAnswer(
            (_) async => const HttpClientResponse(
              data: {
                'data': {'otp_expires_in_seconds': 60, 'otp_length': 6},
              },
              statusCode: 200,
            ),
          );

          when(
            () => httpClient.post(
              '/api/student/register/complete',
              data: any(named: 'data'),
            ),
          ).thenAnswer(
            (_) async => const HttpClientResponse(
              data: {'data': tStudentData},
              statusCode: 200,
            ),
          );

          await repository.sendOtp(tPhone);

          // act
          final result = await repository.verifyOtp(tOtp);

          // assert
          expect(result.id, '1');
          expect(result.name, 'Test Student');
          verify(
            () => httpClient.post(
              '/api/student/register/complete',
              data: {'phone': tPhone, 'otp': tOtp},
            ),
          ).called(1);
        },
      );
    });

    group('signOut', () {
      test('should call httpClient.post and return normally', () async {
        // arrange
        when(() => httpClient.post('/api/auth/student/logout')).thenAnswer(
          (_) async => const HttpClientResponse(data: {}, statusCode: 200),
        );
        when(() => cacheRepository.remove(any())).thenAnswer((_) async {});

        // act & assert
        await expectLater(repository.signOut(), completes);
        verify(() => httpClient.post('/api/auth/student/logout')).called(1);
      });
    });

    group('getCurrentUser', () {
      test(
        'should call httpClient.get and return StudentEntity on success',
        () async {
          // arrange
          when(
            () => httpClient.isAuthenticated(),
          ).thenAnswer((_) async => true);
          when(() => httpClient.get('/api/auth/student/me')).thenAnswer(
            (_) async => const HttpClientResponse(
              data: {'data': tStudentData},
              statusCode: 200,
            ),
          );
          when(
            () => cacheRepository.put(any(), any()),
          ).thenAnswer((_) async {});

          // act
          final result = await repository.getCurrentUser();

          // assert
          expect(result?.id, '1');
          verify(() => httpClient.get('/api/auth/student/me')).called(1);
        },
      );

      test('should return null when status code is 401', () async {
        // arrange
        when(() => httpClient.isAuthenticated()).thenAnswer((_) async => true);
        when(() => httpClient.get(any())).thenAnswer(
          (_) async => const HttpClientResponse(data: {}, statusCode: 401),
        );

        // act
        final result = await repository.getCurrentUser();

        // assert
        expect(result, isNull);
      });
    });
  });
}
