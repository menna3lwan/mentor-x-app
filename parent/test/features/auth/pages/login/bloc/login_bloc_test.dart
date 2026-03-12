import 'package:bloc_presentation_test/bloc_presentation_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parent/features/auth/pages/login/bloc/login_bloc.dart';
import 'package:parent_core/parent_core.dart';

class MockAuthRepository extends Mock implements AuthenticationRepository {}

void main() {
  late MockAuthRepository authRepository;

  const tPhone = '01000000000';
  const tPassword = 'password123';
  const tUser = ParentEntity(
    id: 'user-1',
    name: 'Test Parent',
    phoneNumber: tPhone,
  );
  const tAuthException = AuthenticationException(
    code: AuthenticationExceptionCode.invalidCredentials,
    message: 'Invalid credentials',
  );

  setUp(() {
    authRepository = MockAuthRepository();
  });

  group('LoginBloc', () {
    test('initial state is LoginState.initial', () {
      final bloc = LoginBloc(authenticationRepository: authRepository);
      expect(bloc.state, LoginState.initial);
      bloc.close();
    });

    blocTest<LoginBloc, LoginState>(
      'emits [loading, success] and LoginSuccessPresentationEvent on successful login',
      build: () {
        when(
          () => authRepository.login(
            phone: tPhone,
            password: tPassword,
          ),
        ).thenAnswer((_) async => tUser);
        return LoginBloc(authenticationRepository: authRepository);
      },
      act: (bloc) => bloc.add(const LoginSubmittedEvent(
        phoneNumber: tPhone,
        password: tPassword,
      )),
      expect: () => [
        LoginState.initial.copyWith(loadingState: LoginLoadingState.loading),
        LoginState.initial.copyWith(loadingState: LoginLoadingState.success),
      ],
      verify: (_) {
        verify(() => authRepository.login(
              phone: tPhone,
              password: tPassword,
            )).called(1);
      },
    );

    blocPresentationTest<LoginBloc, LoginState, LoginPresentationEvent>(
      'emits LoginSuccessPresentationEvent on successful login',
      build: () {
        when(
          () => authRepository.login(
            phone: tPhone,
            password: tPassword,
          ),
        ).thenAnswer((_) async => tUser);
        return LoginBloc(authenticationRepository: authRepository);
      },
      act: (bloc) => bloc.add(const LoginSubmittedEvent(
        phoneNumber: tPhone,
        password: tPassword,
      )),
      expectPresentation: () => [
        isA<LoginSuccessPresentationEvent>()
            .having((e) => e.user, 'user', tUser),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [loading, failure] on AuthenticationException',
      build: () {
        when(
          () => authRepository.login(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
          ),
        ).thenThrow(tAuthException);
        return LoginBloc(authenticationRepository: authRepository);
      },
      act: (bloc) => bloc.add(const LoginSubmittedEvent(
        phoneNumber: tPhone,
        password: 'wrongpass',
      )),
      expect: () => [
        LoginState.initial.copyWith(loadingState: LoginLoadingState.loading),
        LoginState.initial.copyWith(
          loadingState: LoginLoadingState.failure,
          exception: tAuthException,
        ),
      ],
    );

    blocPresentationTest<LoginBloc, LoginState, LoginPresentationEvent>(
      'emits LoginFailurePresentationEvent on AuthenticationException',
      build: () {
        when(
          () => authRepository.login(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
          ),
        ).thenThrow(tAuthException);
        return LoginBloc(authenticationRepository: authRepository);
      },
      act: (bloc) => bloc.add(const LoginSubmittedEvent(
        phoneNumber: tPhone,
        password: 'wrongpass',
      )),
      expectPresentation: () => [
        isA<LoginFailurePresentationEvent>()
            .having((e) => e.exception, 'exception', tAuthException),
      ],
    );

    blocTest<LoginBloc, LoginState>(
      'emits [loading, failure] with unknown code on unexpected exception',
      build: () {
        when(
          () => authRepository.login(
            phone: any(named: 'phone'),
            password: any(named: 'password'),
          ),
        ).thenThrow(Exception('network failure'));
        return LoginBloc(authenticationRepository: authRepository);
      },
      act: (bloc) => bloc.add(const LoginSubmittedEvent(
        phoneNumber: tPhone,
        password: tPassword,
      )),
      expect: () => [
        LoginState.initial.copyWith(loadingState: LoginLoadingState.loading),
        LoginState.initial.copyWith(
          loadingState: LoginLoadingState.failure,
          exception: const AuthenticationException(
            code: AuthenticationExceptionCode.unknown,
          ),
        ),
      ],
    );
  });
}
