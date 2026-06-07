import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/account_status/pages/status_pending/bloc/status_pending_bloc.dart';

class _MockStudentAuthenticationRepository extends Mock
    implements StudentAuthenticationRepository {}

class _MockCacheRepository extends Mock implements CacheRepository {}

class _MockAnalyticsService implements AnalyticsService {
  @override
  Future<void> initialize() async {}
  @override
  Future<void> logEvent({required String name, Map<String, Object?>? parameters}) async {}
  @override
  Future<void> setCurrentScreen({required String screenName, String? screenClassOverride}) async {}
  @override
  Future<void> setUserId(String? id) async {}
  @override
  Future<void> setUserProperty({required String name, required String? value}) async {}
  @override
  Future<void> resetAnalyticsData() async {}
}

void main() {
  late _MockStudentAuthenticationRepository authenticationRepository;
  late _MockCacheRepository cacheRepository;
  late _MockAnalyticsService analyticsService;

  final pendingUser = StudentEntity(
    id: '1',
    firstName: 'Pending',
    lastName: 'Student',
    phoneNumber: '01000000000',
    studentCode: 'ST-001',
    status: StudentStatus.pending,
    createdAt: DateTime(2025),
    updatedAt: DateTime(2025),
  );

  setUp(() {
    authenticationRepository = _MockStudentAuthenticationRepository();
    cacheRepository = _MockCacheRepository();
    analyticsService = _MockAnalyticsService();

    when(
      () => authenticationRepository.getCachedUser(),
    ).thenAnswer((_) async => pendingUser);
    when(
      () => authenticationRepository.getAccountStatus(),
    ).thenAnswer((_) async => pendingUser);
    when(() => cacheRepository.get(any())).thenAnswer((_) async => null);
  });

  group('StatusPendingBloc', () {
    test('initial state is correct', () {
      final bloc = StatusPendingBloc(
        authRepository: authenticationRepository,
        cacheRepository: cacheRepository,
        analyticsService: analyticsService,
      );
      expect(bloc.state, StatusPendingState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<StatusPendingBloc, StatusPendingState>(
      'emits loaded and refreshes account status when initialized',
      build: () => StatusPendingBloc(
        authRepository: authenticationRepository,
        cacheRepository: cacheRepository,
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const StatusPendingInitialized()),
      expect: () => [
        isA<StatusPendingState>()
            .having(
              (s) => s.loadingState,
              'loadingState',
              LoadingState.loaded,
            )
            .having(
              (s) => s.studentCode,
              'studentCode',
              pendingUser.studentCode,
            ),
        isA<StatusPendingState>().having(
          (s) => s.isRefreshing,
          'isRefreshing',
          true,
        ),
        isA<StatusPendingState>()
            .having(
              (s) => s.isRefreshing,
              'isRefreshing',
              false,
            )
            .having(
              (s) => s.studentCode,
              'studentCode',
              pendingUser.studentCode,
            ),
      ],
    );
  });
}
