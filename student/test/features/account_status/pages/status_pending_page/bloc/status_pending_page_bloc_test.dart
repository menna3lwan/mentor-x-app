import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/account_status/pages/status_pending_page/bloc/status_pending_page_bloc.dart';

class _MockStudentAuthenticationRepository extends Mock
    implements StudentAuthenticationRepository {}

class _MockCacheRepository extends Mock implements CacheRepository {}

void main() {
  late _MockStudentAuthenticationRepository authenticationRepository;
  late _MockCacheRepository cacheRepository;

  final pendingUser = StudentEntity(
    id: '1',
    name: 'Pending Student',
    phoneNumber: '01000000000',
    studentCode: 'ST-001',
    status: StudentStatus.pending,
    createdAt: DateTime(2025),
    updatedAt: DateTime(2025),
  );

  setUp(() {
    authenticationRepository = _MockStudentAuthenticationRepository();
    cacheRepository = _MockCacheRepository();

    when(
      () => authenticationRepository.getCachedUser(),
    ).thenAnswer((_) async => pendingUser);
    when(
      () => authenticationRepository.getAccountStatus(),
    ).thenAnswer((_) async => pendingUser);
    when(() => cacheRepository.get(any())).thenAnswer((_) async => null);
  });

  group('StatusPendingPageBloc', () {
    test('initial state is correct', () {
      final bloc = StatusPendingPageBloc(
        authRepository: authenticationRepository,
        cacheRepository: cacheRepository,
      );
      expect(bloc.state, StatusPendingPageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<StatusPendingPageBloc, StatusPendingPageState>(
      'emits loaded and refreshes account status when initialized',
      build: () => StatusPendingPageBloc(
        authRepository: authenticationRepository,
        cacheRepository: cacheRepository,
      ),
      act: (bloc) => bloc.add(const StatusPendingPageInitialized()),
      expect: () => [
        isA<StatusPendingPageState>()
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
        isA<StatusPendingPageState>().having(
          (s) => s.isRefreshing,
          'isRefreshing',
          true,
        ),
        isA<StatusPendingPageState>()
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
