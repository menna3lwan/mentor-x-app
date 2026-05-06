import 'dart:convert';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:dio_authentication_repository/dio_authentication_repository.dart';

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
    
    // Register fallbacks for mocktail
    registerFallbackValue(<String, dynamic>{});
    registerFallbackValue(<String, String>{});

    // Default mocks for HttpClient Future<void> methods
    when(() => httpClient.setAccessToken(any())).thenAnswer((_) async {});
    when(() => httpClient.setRefreshToken(any())).thenAnswer((_) async {});
    when(() => httpClient.clearTokens()).thenAnswer((_) async {});
  });

  group('DioAuthenticationRepository', () {
    group('loginWithPassword', () {
      const phoneNumber = '01192789890';
      const password = 'string';
      
      test('successfully logs in and fetches user from /api/auth/me if missing in login response', () async {
        final mockLoginResponse = {
          'success': true,
          'token': 'fake-token',
          'deviceId': 'fake-device',
        };

        final mockUser = {
          'id': 'user-1',
          'first_name': 'Test',
          'last_name': 'User',
          'phone': phoneNumber,
        };

        when(() => cacheRepository.get(any())).thenAnswer((_) async => null);
        when(() => cacheRepository.put(any(), any())).thenAnswer((_) async {});
        
        // Mock Login
        when(() => httpClient.post(
          any(),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          headers: any(named: 'headers'),
        )).thenAnswer((_) async => HttpClientResponse(
          data: mockLoginResponse,
          statusCode: 200,
        ));

        // Mock isAuthenticated check called by getCurrentUser
        when(() => httpClient.isAuthenticated).thenReturn(true);

        // Mock GET /api/auth/me
        when(() => httpClient.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          headers: any(named: 'headers'),
        )).thenAnswer((_) async => HttpClientResponse(
          data: mockUser,
          statusCode: 200,
        ));

        final result = await repository.loginWithPassword(
          phoneNumber: phoneNumber,
          password: password,
        );

        expect(result.id, 'user-1');
        verify(() => httpClient.post(
          any(),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          headers: any(named: 'headers'),
        )).called(1);
        verify(() => httpClient.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          headers: any(named: 'headers'),
        )).called(1);
        verify(() => cacheRepository.put(CacheKeys.user, any())).called(2);
      });

      test('throws AuthenticationRepositoryException on session active error', () async {
        when(() => cacheRepository.get(any())).thenAnswer((_) async => null);
        when(() => httpClient.post(
          any(),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          headers: any(named: 'headers'),
        )).thenThrow(const HttpClientResponse(
          data: {
            'success': false,
            'error': 'الحساب مسجل دخول على جهاز آخر. يجب تسجيل الخروج أولاً'
          },
          statusCode: 400,
        ));

        expect(
          () => repository.loginWithPassword(phoneNumber: phoneNumber, password: password),
          throwsA(isA<AuthenticationRepositoryException>().having(
            (e) => e.code,
            'code',
            AuthenticationRepositoryExceptionCode.sessionAlreadyActive,
          )),
        );
      });
    });

    group('getCurrentUser', () {
      test('returns cached user if present', () async {
        final cachedUserJson = json.encode({
          'id': 'cached-1',
          'first_name': 'Cached',
          'last_name': 'User',
          'phone': '123',
          'status': 'active',
        });

        when(() => cacheRepository.get(CacheKeys.user)).thenAnswer((_) async => cachedUserJson);

        final result = await repository.getCachedUser();
        expect(result?.id, 'cached-1');
      });

      test('fetches from server and caches if authenticated', () async {
        final mockUser = {
          'id': 'server-1',
          'first_name': 'Server',
          'last_name': 'User',
        };

        when(() => httpClient.isAuthenticated).thenReturn(true);

        when(() => httpClient.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          headers: any(named: 'headers'),
        )).thenAnswer((_) async => HttpClientResponse(
          data: mockUser,
          statusCode: 200,
        ));
        when(() => cacheRepository.put(any(), any())).thenAnswer((_) async {});

        final result = await repository.getCurrentUser();
        expect(result?.id, 'server-1');
        verify(() => cacheRepository.put(CacheKeys.user, any())).called(1);
      });
    });

    group('logout', () {
      test('clears local state and calls backend', () async {
        when(() => httpClient.post(
          any(),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          headers: any(named: 'headers'),
        )).thenAnswer((_) async => const HttpClientResponse(
          data: {},
          statusCode: 200,
        ));
        when(() => cacheRepository.remove(any())).thenAnswer((_) async {});

        await repository.logout();

        verify(() => httpClient.post(
          any(),
          data: any(named: 'data'),
          queryParameters: any(named: 'queryParameters'),
          headers: any(named: 'headers'),
        )).called(1);
        verify(() => httpClient.clearTokens()).called(1);
        verify(() => cacheRepository.remove(CacheKeys.user)).called(1);
      });
    });

    group('getAccountStatus', () {
      test('returns StudentEntity on slim session-status response', () async {
        final mockResponse = {
          'role': 'STUDENT',
          'studentCode': 'G2766',
          'hasSession': true,
          'status': 'ACTIVE',
        };

        when(() => httpClient.get(
          '/api/auth/session-status',
          queryParameters: any(named: 'queryParameters'),
          headers: any(named: 'headers'),
        )).thenAnswer((_) async => HttpClientResponse(
          data: mockResponse,
          statusCode: 200,
        ));
        when(() => cacheRepository.put(any(), any())).thenAnswer((_) async {});

        final result = await repository.getAccountStatus();
        
        expect(result.studentCode, 'G2766');
        expect(result.status, StudentStatus.active);
        expect(result.firstName, 'Student'); // Skeleton default
      });
    });
  });
}
