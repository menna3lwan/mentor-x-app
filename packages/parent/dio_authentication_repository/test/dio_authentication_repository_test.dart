import 'package:flutter_test/flutter_test.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parent_authentication_repository/dio_authentication_repository.dart';

class _MockHttpClient extends Mock implements HttpClient {}

class _MockCacheRepository extends Mock implements CacheRepository {}

void main() {
  late _MockHttpClient httpClient;
  late _MockCacheRepository cacheRepository;
  late DioAuthenticationRepository repository;

  const phone = '01000000000';

  setUp(() {
    httpClient = _MockHttpClient();
    cacheRepository = _MockCacheRepository();
    repository = DioAuthenticationRepository(
      httpClient: httpClient,
      cacheRepository: cacheRepository,
    );
  });

  group('requestPasswordReset', () {
    test('succeeds on v1 endpoint', () async {
      when(
        () => httpClient.post(
          '/api/v1/auth/forgot-password',
          data: {'phone': phone},
        ),
      ).thenAnswer(
        (_) async => const HttpClientResponse(data: {}, statusCode: 200),
      );

      await repository.requestPasswordReset(phone);

      verify(
        () => httpClient.post(
          '/api/v1/auth/forgot-password',
          data: {'phone': phone},
        ),
      ).called(1);
    });

    test('falls back to legacy endpoint on 404', () async {
      when(
        () => httpClient.post(
          '/api/v1/auth/forgot-password',
          data: {'phone': phone},
        ),
      ).thenThrow(
        HttpClientResponse(
          data: {},
          statusCode: 404,
          exception: HttpClientException(
            code: HttpClientExceptionCode.notFound,
          ),
        ),
      );
      when(
        () => httpClient.post(
          '/api/auth/forgot-password',
          data: {'phone': phone},
        ),
      ).thenAnswer(
        (_) async => const HttpClientResponse(data: {}, statusCode: 200),
      );

      await repository.requestPasswordReset(phone);

      verify(
        () => httpClient.post(
          '/api/auth/forgot-password',
          data: {'phone': phone},
        ),
      ).called(1);
    });
  });

  group('resetPassword', () {
    test('succeeds on primary payload', () async {
      when(
        () => httpClient.post(
          '/api/v1/auth/reset-password',
          data: {
            'phone': phone,
            'otp': '123456',
            'new_password': 'StrongPass1!',
          },
        ),
      ).thenAnswer(
        (_) async => const HttpClientResponse(data: {}, statusCode: 200),
      );

      await repository.resetPassword(
        phone: phone,
        otp: '123456',
        newPassword: 'StrongPass1!',
      );

      verify(
        () => httpClient.post(
          '/api/v1/auth/reset-password',
          data: {
            'phone': phone,
            'otp': '123456',
            'new_password': 'StrongPass1!',
          },
        ),
      ).called(1);
    });

    test('falls back to secondary payload on 422', () async {
      when(
        () => httpClient.post(
          '/api/v1/auth/reset-password',
          data: {
            'phone': phone,
            'otp': '123456',
            'new_password': 'StrongPass1!',
          },
        ),
      ).thenThrow(
        HttpClientResponse(
          data: {},
          statusCode: 422,
          exception: HttpClientException(
            code: HttpClientExceptionCode.badResponse,
          ),
        ),
      );
      when(
        () => httpClient.post(
          '/api/v1/auth/reset-password',
          data: {
            'phone': phone,
            'otp_code': '123456',
            'password': 'StrongPass1!',
          },
        ),
      ).thenAnswer(
        (_) async => const HttpClientResponse(data: {}, statusCode: 200),
      );

      await repository.resetPassword(
        phone: phone,
        otp: '123456',
        newPassword: 'StrongPass1!',
      );

      verify(
        () => httpClient.post(
          '/api/v1/auth/reset-password',
          data: {
            'phone': phone,
            'otp_code': '123456',
            'password': 'StrongPass1!',
          },
        ),
      ).called(1);
    });
  });
}
