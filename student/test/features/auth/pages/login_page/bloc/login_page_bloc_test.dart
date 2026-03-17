import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_authentication_repository/mock_authentication_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/auth/pages/login_page/bloc/login_page_bloc.dart';

void main() {
  late MockAuthenticationRepository authRepository;
  late MockAuthenticationRepository uninitializedAuthRepository;

  setUp(() async {
    authRepository = MockAuthenticationRepository(delay: Duration.zero);
    await authRepository.initialize();

    // NOT initialized -- sendOtp will throw AuthenticationRepositoryException
    uninitializedAuthRepository = MockAuthenticationRepository(
      delay: Duration.zero,
    );
  });

  group('LoginPageBloc', () {
    // ── 1. Initial state ────────────────────────────────────────────────
    test('initial state is correct', () {
      final bloc = LoginPageBloc(authRepository: authRepository);

      expect(bloc.state, LoginPageState.initial);
      expect(bloc.state.phoneNumber, '');
      expect(bloc.state.loadingState, LoadingState.initial);
      expect(bloc.state.errorMessage, isNull);
      expect(bloc.state.isLoading, isFalse);

      bloc.close();
    });

    // ── 2. PhoneChanged happy path ──────────────────────────────────────
    blocTest<LoginPageBloc, LoginPageState>(
      'emits state with updated phone number when PhoneChanged is added',
      build: () => LoginPageBloc(authRepository: authRepository),
      act: (bloc) => bloc.add(const LoginPagePhoneChanged('0501234567')),
      expect: () => [
        isA<LoginPageState>()
            .having((s) => s.phoneNumber, 'phoneNumber', '0501234567')
            .having(
              (s) => s.loadingState,
              'loadingState',
              LoadingState.initial,
            )
            .having((s) => s.errorMessage, 'errorMessage', isNull),
      ],
    );

    // ── 3. PhoneChanged clears previous error message ───────────────────
    blocTest<LoginPageBloc, LoginPageState>(
      'PhoneChanged clears previous error message',
      build: () => LoginPageBloc(authRepository: authRepository),
      seed: () => const LoginPageState(
        phoneNumber: '0501234567',
        loadingState: LoadingState.error,
        errorMessage: 'Something went wrong',
      ),
      act: (bloc) => bloc.add(const LoginPagePhoneChanged('0509876543')),
      expect: () => [
        isA<LoginPageState>()
            .having((s) => s.phoneNumber, 'phoneNumber', '0509876543')
            .having(
              (s) => s.loadingState,
              'loadingState',
              LoadingState.initial,
            )
            .having((s) => s.errorMessage, 'errorMessage', isNull),
      ],
    );

    // ── 4. Submitted with empty phone number does nothing ───────────────
    blocTest<LoginPageBloc, LoginPageState>(
      'does nothing when submitted with empty phone number',
      build: () => LoginPageBloc(authRepository: authRepository),
      // state.phoneNumber is '' by default (LoginPageState.initial)
      act: (bloc) => bloc.add(const LoginPageSubmitted()),
      expect: () => <LoginPageState>[],
    );

    // ── 5. Submitted with whitespace-only phone number does nothing ─────
    blocTest<LoginPageBloc, LoginPageState>(
      'does nothing when submitted with whitespace-only phone number',
      build: () => LoginPageBloc(authRepository: authRepository),
      seed: () => const LoginPageState(
        phoneNumber: '   ',
        loadingState: LoadingState.initial,
      ),
      act: (bloc) => bloc.add(const LoginPageSubmitted()),
      expect: () => <LoginPageState>[],
    );

    // ── 6. Submitted happy path: loading -> loaded ──────────────────────
    blocTest<LoginPageBloc, LoginPageState>(
      'emits [loading, loaded] when submitted with valid phone number',
      build: () => LoginPageBloc(authRepository: authRepository),
      seed: () => const LoginPageState(
        phoneNumber: '0501234567',
        loadingState: LoadingState.initial,
      ),
      act: (bloc) => bloc.add(const LoginPageSubmitted()),
      expect: () => [
        isA<LoginPageState>()
            .having(
              (s) => s.loadingState,
              'loadingState',
              LoadingState.loading,
            )
            .having((s) => s.phoneNumber, 'phoneNumber', '0501234567'),
        isA<LoginPageState>()
            .having(
              (s) => s.loadingState,
              'loadingState',
              LoadingState.loaded,
            )
            .having((s) => s.phoneNumber, 'phoneNumber', '0501234567'),
      ],
    );

    // ── 7. Error state when repository is not initialized ───────────────
    blocTest<LoginPageBloc, LoginPageState>(
      'emits error state when repository is not initialized',
      build: () => LoginPageBloc(authRepository: uninitializedAuthRepository),
      seed: () => const LoginPageState(
        phoneNumber: '0501234567',
        loadingState: LoadingState.initial,
      ),
      act: (bloc) => bloc.add(const LoginPageSubmitted()),
      expect: () => [
        isA<LoginPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<LoginPageState>()
            .having(
              (s) => s.loadingState,
              'loadingState',
              LoadingState.error,
            )
            .having(
              (s) => s.errorMessage,
              'errorMessage',
              'Repository not initialized',
            ),
      ],
    );

    // ── 8. Error cleared after phone change following error ─────────────
    blocTest<LoginPageBloc, LoginPageState>(
      'clears error after phone change following error',
      build: () => LoginPageBloc(authRepository: uninitializedAuthRepository),
      seed: () => const LoginPageState(
        phoneNumber: '0501234567',
        loadingState: LoadingState.error,
        errorMessage: 'Repository not initialized',
      ),
      act: (bloc) => bloc.add(const LoginPagePhoneChanged('0507777777')),
      expect: () => [
        isA<LoginPageState>()
            .having((s) => s.phoneNumber, 'phoneNumber', '0507777777')
            .having(
              (s) => s.loadingState,
              'loadingState',
              LoadingState.initial,
            )
            .having((s) => s.errorMessage, 'errorMessage', isNull),
      ],
    );
  });
}
