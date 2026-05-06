import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_authentication_repository/mock_authentication_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/auth/pages/login/bloc/login_bloc.dart';

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

  group('LoginBloc', () {
    // ── 1. Initial state ────────────────────────────────────────────────
    test('initial state is correct', () {
      final bloc = LoginBloc(authRepository: authRepository);

      expect(bloc.state, LoginState.initial);
      expect(bloc.state.phoneNumber, '');
      expect(bloc.state.loadingState, LoadingState.initial);
      expect(bloc.state.errorMessage, isNull);
      expect(bloc.state.isLoading, isFalse);

      bloc.close();
    });

    // ── 2. PhoneChanged happy path ──────────────────────────────────────
    blocTest<LoginBloc, LoginState>(
      'emits state with updated phone number when PhoneChanged is added',
      build: () => LoginBloc(authRepository: authRepository),
      act: (bloc) => bloc.add(const LoginPhoneChanged('0501234567')),
      expect: () => [
        isA<LoginState>()
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
    blocTest<LoginBloc, LoginState>(
      'PhoneChanged clears previous error message',
      build: () => LoginBloc(authRepository: authRepository),
      seed: () => const LoginState(
        phoneNumber: '0501234567',
        password: '',
        obscurePassword: true,
        loadingState: LoadingState.error,
        errorMessage: 'Something went wrong',
      ),
      act: (bloc) => bloc.add(const LoginPhoneChanged('0509876543')),
      expect: () => [
        isA<LoginState>()
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
    blocTest<LoginBloc, LoginState>(
      'does nothing when submitted with empty phone number',
      build: () => LoginBloc(authRepository: authRepository),
      // state.phoneNumber is '' by default (LoginState.initial)
      act: (bloc) => bloc.add(const LoginSubmitted()),
      expect: () => <LoginState>[],
    );

    // ── 5. Submitted with whitespace-only phone number does nothing ─────
    blocTest<LoginBloc, LoginState>(
      'does nothing when submitted with whitespace-only phone number',
      build: () => LoginBloc(authRepository: authRepository),
      seed: () => const LoginState(
        phoneNumber: '   ',
        password: '',
        obscurePassword: true,
        loadingState: LoadingState.initial,
      ),
      act: (bloc) => bloc.add(const LoginSubmitted()),
      expect: () => <LoginState>[],
    );

    // ── 6. Submitted happy path: loading -> loaded ──────────────────────
    blocTest<LoginBloc, LoginState>(
      'emits [loading, loaded] when submitted with valid phone number',
      build: () => LoginBloc(authRepository: authRepository),
      seed: () => const LoginState(
        phoneNumber: '0501234567',
        password: 'password123',
        obscurePassword: true,
        loadingState: LoadingState.initial,
      ),
      act: (bloc) => bloc.add(const LoginSubmitted()),
      expect: () => [
        isA<LoginState>()
            .having(
              (s) => s.loadingState,
              'loadingState',
              LoadingState.loading,
            )
            .having((s) => s.phoneNumber, 'phoneNumber', '0501234567'),
        isA<LoginState>()
            .having(
              (s) => s.loadingState,
              'loadingState',
              LoadingState.loaded,
            )
            .having((s) => s.phoneNumber, 'phoneNumber', '0501234567'),
      ],
    );

    // ── 7. Error state when repository is not initialized ───────────────
    blocTest<LoginBloc, LoginState>(
      'emits error state when repository is not initialized',
      build: () => LoginBloc(authRepository: uninitializedAuthRepository),
      seed: () => const LoginState(
        phoneNumber: '0501234567',
        password: 'password123',
        obscurePassword: true,
        loadingState: LoadingState.initial,
      ),
      act: (bloc) => bloc.add(const LoginSubmitted()),
      expect: () => [
        isA<LoginState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<LoginState>()
            .having(
              (s) => s.loadingState,
              'loadingState',
              LoadingState.error,
            )
            .having(
              (s) => s.errorMessage,
              'errorMessage',
              contains('Repository not initialized'),
            ),
      ],
    );

    // ── 8. Error cleared after phone change following error ─────────────
    blocTest<LoginBloc, LoginState>(
      'clears error after phone change following error',
      build: () => LoginBloc(authRepository: uninitializedAuthRepository),
      seed: () => const LoginState(
        phoneNumber: '0501234567',
        password: '',
        obscurePassword: true,
        loadingState: LoadingState.error,
        errorMessage: 'Repository not initialized',
      ),
      act: (bloc) => bloc.add(const LoginPhoneChanged('0507777777')),
      expect: () => [
        isA<LoginState>()
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
