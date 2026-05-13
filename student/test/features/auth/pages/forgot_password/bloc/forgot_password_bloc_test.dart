import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mentorx_student/features/auth/pages/forgot_password/bloc/forgot_password_bloc.dart';

class MockAnalyticsService extends Mock implements AnalyticsService {}


class MockStudentAuthenticationRepository extends Mock
    implements StudentAuthenticationRepository {}

void main() {
  late AnalyticsService analyticsService;
  late StudentAuthenticationRepository authRepository;
  late ForgotPasswordBloc forgotPasswordBloc;

  setUp(() {
    analyticsService = MockAnalyticsService();
    authRepository = MockStudentAuthenticationRepository();
    forgotPasswordBloc = ForgotPasswordBloc(authRepository: authRepository, analyticsService: analyticsService);
  });

  tearDown(() {
    forgotPasswordBloc.close();
  });

  group('ForgotPasswordBloc', () {
    test('initial state is correct', () {
      expect(forgotPasswordBloc.state, const ForgotPasswordState());
    });

    blocTest<ForgotPasswordBloc, ForgotPasswordState>(
      'emits updated phone when ForgotPasswordPhoneChanged is added',
      build: () => forgotPasswordBloc,
      act: (bloc) => bloc.add(const ForgotPasswordPhoneChanged('01234567890')),
      expect: () => [
        const ForgotPasswordState(phone: '01234567890'),
      ],
    );

    blocTest<ForgotPasswordBloc, ForgotPasswordState>(
      'emits success when ForgotPasswordSubmitted is successful',
      build: () {
        when(
          () => authRepository.requestPasswordReset(any()),
        ).thenAnswer((_) async {});
        return ForgotPasswordBloc(authRepository: authRepository,
          initialPhone: '01234567890',
        analyticsService: analyticsService,
      );
      },
      act: (bloc) => bloc.add(const ForgotPasswordSubmitted()),
      expect: () => [
        const ForgotPasswordState(
          phone: '01234567890',
          loadingState: LoadingState.loading,
        ),
        const ForgotPasswordState(
          phone: '01234567890',
          loadingState: LoadingState.loaded,
        ),
      ],
      verify: (_) {
        verify(
          () => authRepository.requestPasswordReset('01234567890'),
        ).called(1);
      },
    );

    blocTest<ForgotPasswordBloc, ForgotPasswordState>(
      'emits failure when ForgotPasswordSubmitted fails',
      build: () {
        when(() => authRepository.requestPasswordReset(any())).thenThrow(
          AuthenticationRepositoryException(
            code: AuthenticationRepositoryExceptionCode.unknown,
            message: 'Error',
          ),
        );
        return ForgotPasswordBloc(authRepository: authRepository,
          initialPhone: '01234567890',
        analyticsService: analyticsService,
      );
      },
      act: (bloc) => bloc.add(const ForgotPasswordSubmitted()),
      expect: () => [
        const ForgotPasswordState(
          phone: '01234567890',
          loadingState: LoadingState.loading,
        ),
        const ForgotPasswordState(
          phone: '01234567890',
          loadingState: LoadingState.error,
          errorMessage: 'Error',
        ),
      ],
    );
  });
}
