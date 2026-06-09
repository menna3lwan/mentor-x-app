import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:parent_dio_authentication_repository/parent_dio_authentication_repository.dart';
import 'package:mentorx_core/mentorx_core.dart';

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
  });

  test('login starts the Swagger OTP flow for parents', () async {
    const phoneNumber = '01000000000';

    when(
      () => httpClient.post(
        '/api/parent/start-login',
        data: {'parentPhone': phoneNumber},
      ),
    ).thenAnswer(
      (_) async => const HttpClientResponse(
        data: {'status': 'ok'},
        statusCode: 200,
      ),
    );

    expect(
      () => repository.login(phone: phoneNumber, password: 'unused-password'),
      throwsA(
        isA<AuthenticationException>().having(
          (exception) => exception.code,
          'code',
          AuthenticationExceptionCode.otpRequired,
        ),
      ),
    );

    verify(
      () => httpClient.post(
        '/api/parent/start-login',
        data: {'parentPhone': phoneNumber},
      ),
    ).called(1);
  });
}
