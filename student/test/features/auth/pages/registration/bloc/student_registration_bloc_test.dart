import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_presentation_test/bloc_presentation_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/auth/pages/registration/bloc/student_registration_bloc.dart';

class MockStudentRegistrationRepository extends Mock
    implements StudentRegistrationRepository {}

void main() {
  late StudentRegistrationRepository repo;
  const tenantId = 'test-tenant';

  setUpAll(() {
    registerFallbackValue(const StudentRegistrationState());
  });

  setUp(() {
    repo = MockStudentRegistrationRepository();
    when(() => repo.getGovernorates()).thenAnswer((_) async => []);
    when(() => repo.getApplicationInfo()).thenAnswer(
      (_) async => const StudentApplicationInfoEntity(
        requiredDocuments: [],
        supportInfo: SupportInfoEntity(
          whatsapp: '',
          email: '',
          workingHours: '',
        ),
        steps: [],
        grades: [],
      ),
    );
  });

  StudentRegistrationBloc buildBloc() =>
      StudentRegistrationBloc(registrationRepository: repo, tenantId: tenantId);

  group('StudentRegistrationBloc', () {
    // ── Initial state ─────────────────────────────────────────────────
    test('initial state is correct', () {
      final bloc = buildBloc();
      expect(bloc.state, const StudentRegistrationState());
      bloc.close();
    });

    // ── Bootstrap ─────────────────────────────────────────────────────
    blocTest<StudentRegistrationBloc, StudentRegistrationState>(
      'emits governorates and grades on BootstrapRequested',
      build: () {
        when(() => repo.getGovernorates()).thenAnswer(
          (_) async => [const GovernorateEntity(id: '1', name: 'Cairo')],
        );
        when(() => repo.getApplicationInfo()).thenAnswer(
          (_) async => const StudentApplicationInfoEntity(
            requiredDocuments: [],
            supportInfo: SupportInfoEntity(
              whatsapp: '',
              email: '',
              workingHours: '',
            ),
            steps: [],
            grades: [GradeEntity(id: '1', name: 'Grade 1')],
          ),
        );
        return buildBloc();
      },
      act: (bloc) => bloc.add(const StudentRegistrationBootstrapRequested()),
      expect: () => [
        isA<StudentRegistrationState>()
            .having((s) => s.governorates.length, 'governorates', 1)
            .having((s) => s.grades.length, 'grades', 1),
      ],
    );

    blocTest<StudentRegistrationBloc, StudentRegistrationState>(
      'emits error when bootstrap fails',
      build: () {
        when(() => repo.getGovernorates()).thenThrow(Exception('Network'));
        return buildBloc();
      },
      act: (bloc) => bloc.add(const StudentRegistrationBootstrapRequested()),
      expect: () => [
        isA<StudentRegistrationState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.error,
        ),
      ],
    );

    // ── Field changes ─────────────────────────────────────────────────
    blocTest<StudentRegistrationBloc, StudentRegistrationState>(
      'emits updated firstName on FirstNameChanged',
      build: buildBloc,
      act: (bloc) => bloc.add(const StudentRegistrationFirstNameChanged('Ali')),
      expect: () => [
        isA<StudentRegistrationState>().having(
          (s) => s.firstName,
          'firstName',
          'Ali',
        ),
      ],
    );

    blocTest<StudentRegistrationBloc, StudentRegistrationState>(
      'emits updated otp on OtpChanged',
      build: buildBloc,
      act: (bloc) => bloc.add(const StudentRegistrationOtpChanged('123456')),
      expect: () => [
        isA<StudentRegistrationState>().having((s) => s.otp, 'otp', '123456'),
      ],
    );

    blocTest<StudentRegistrationBloc, StudentRegistrationState>(
      'emits updated password on PasswordChanged',
      build: buildBloc,
      act: (bloc) => bloc.add(const StudentRegistrationPasswordChanged('pass')),
      expect: () => [
        isA<StudentRegistrationState>().having(
          (s) => s.password,
          'password',
          'pass',
        ),
      ],
    );

    // ── Check Phone ───────────────────────────────────────────────────
    blocTest<StudentRegistrationBloc, StudentRegistrationState>(
      'checks phone availability when valid phone is entered',
      build: () {
        when(() => repo.checkPhone(any())).thenAnswer((_) async => true);
        return buildBloc();
      },
      act: (bloc) =>
          bloc.add(const StudentRegistrationPhoneChanged('01012345678')),
      wait: const Duration(seconds: 1),
      verify: (bloc) {
        expect(bloc.state.phone, '01012345678');
        expect(bloc.state.isPhoneUnique, true);
        verify(() => repo.checkPhone('01012345678')).called(1);
      },
    );

    // ── Start Registration ────────────────────────────────────────────
    blocTest<StudentRegistrationBloc, StudentRegistrationState>(
      'moves to OTP step after successful startRegistration',
      build: () {
        when(
          () => repo.startRegistration(phone: any(named: 'phone')),
        ).thenAnswer((_) async {});
        return buildBloc();
      },
      seed: () => const StudentRegistrationState(
        firstName: 'Kamal',
        phone: '01012345678',
        parentPhone: '01112345678',
      ),
      act: (bloc) => bloc.add(const StudentRegistrationStartRequested()),
      expect: () => [
        isA<StudentRegistrationState>().having(
          (s) => s.loadingState,
          'loading',
          LoadingState.loading,
        ),
        isA<StudentRegistrationState>()
            .having((s) => s.loadingState, 'loaded', LoadingState.loaded)
            .having((s) => s.isRegistrationStarted, 'started', true)
            .having((s) => s.currentStep, 'step', 1),
      ],
    );

    blocTest<StudentRegistrationBloc, StudentRegistrationState>(
      'emits error when startRegistration fails',
      build: () {
        when(
          () => repo.startRegistration(phone: any(named: 'phone')),
        ).thenThrow(Exception('Failed'));
        return buildBloc();
      },
      seed: () => const StudentRegistrationState(
        firstName: 'Kamal',
        phone: '01012345678',
        parentPhone: '01112345678',
      ),
      act: (bloc) => bloc.add(const StudentRegistrationStartRequested()),
      expect: () => [
        isA<StudentRegistrationState>().having(
          (s) => s.loadingState,
          'loading',
          LoadingState.loading,
        ),
        isA<StudentRegistrationState>().having(
          (s) => s.loadingState,
          'error',
          LoadingState.error,
        ),
      ],
    );

    // ── Verify OTP ────────────────────────────────────────────────────
    blocTest<StudentRegistrationBloc, StudentRegistrationState>(
      'moves to step 2 after successful OTP verification',
      build: () {
        when(
          () => repo.verifyOtp(
            phone: any(named: 'phone'),
            otp: any(named: 'otp'),
            tenantId: any(named: 'tenantId'),
          ),
        ).thenAnswer((_) async {});
        return buildBloc();
      },
      seed: () => const StudentRegistrationState(
        currentStep: 1,
        phone: '01012345678',
        otp: '123456',
      ),
      act: (bloc) => bloc.add(const StudentRegistrationVerifyOtpRequested()),
      expect: () => [
        isA<StudentRegistrationState>().having(
          (s) => s.loadingState,
          'loading',
          LoadingState.loading,
        ),
        isA<StudentRegistrationState>()
            .having((s) => s.loadingState, 'loaded', LoadingState.loaded)
            .having((s) => s.currentStep, 'step', 2),
      ],
    );

    blocTest<StudentRegistrationBloc, StudentRegistrationState>(
      'emits error when OTP verification fails',
      build: () {
        when(
          () => repo.verifyOtp(
            phone: any(named: 'phone'),
            otp: any(named: 'otp'),
            tenantId: any(named: 'tenantId'),
          ),
        ).thenThrow(Exception('Invalid OTP'));
        return buildBloc();
      },
      seed: () => const StudentRegistrationState(
        currentStep: 1,
        phone: '01012345678',
        otp: '999999',
      ),
      act: (bloc) => bloc.add(const StudentRegistrationVerifyOtpRequested()),
      expect: () => [
        isA<StudentRegistrationState>().having(
          (s) => s.loadingState,
          'loading',
          LoadingState.loading,
        ),
        isA<StudentRegistrationState>().having(
          (s) => s.loadingState,
          'error',
          LoadingState.error,
        ),
      ],
    );

    // ── Resend OTP ────────────────────────────────────────────────────
    blocPresentationTest<
      StudentRegistrationBloc,
      StudentRegistrationState,
      StudentRegistrationPresentationEvent
    >(
      'emits OtpSent presentation event on resendOtp success',
      build: () {
        when(() => repo.resendOtp(any())).thenAnswer((_) async {});
        return buildBloc();
      },
      seed: () => const StudentRegistrationState(phone: '01012345678'),
      act: (bloc) => bloc.add(const StudentRegistrationResendOtpRequested()),
      expectPresentation: () => [
        isA<StudentRegistrationOtpSentPresentationEvent>(),
      ],
    );

    blocPresentationTest<
      StudentRegistrationBloc,
      StudentRegistrationState,
      StudentRegistrationPresentationEvent
    >(
      'emits failure presentation event on resendOtp failure',
      build: () {
        when(() => repo.resendOtp(any())).thenThrow(Exception('Failed'));
        return buildBloc();
      },
      seed: () => const StudentRegistrationState(phone: '01012345678'),
      act: (bloc) => bloc.add(const StudentRegistrationResendOtpRequested()),
      expectPresentation: () => [
        isA<StudentRegistrationFailurePresentationEvent>(),
      ],
    );

    // ── Governorate → Areas ───────────────────────────────────────────
    blocTest<StudentRegistrationBloc, StudentRegistrationState>(
      'loads areas when governorate is changed',
      build: () {
        when(
          () => repo.getAreas('1'),
        ).thenAnswer((_) async => ['Maadi', 'Nasr City']);
        return buildBloc();
      },
      act: (bloc) => bloc.add(
        const StudentRegistrationGovernorateChanged(
          GovernorateEntity(id: '1', name: 'Cairo'),
        ),
      ),
      wait: const Duration(milliseconds: 300),
      expect: () => [
        // First: governorate set, area cleared
        isA<StudentRegistrationState>()
            .having((s) => s.selectedGovernorate?.id, 'gov', '1')
            .having((s) => s.selectedArea, 'area', isNull),
        // Second: areas loaded
        isA<StudentRegistrationState>().having((s) => s.areas, 'areas', [
          'Maadi',
          'Nasr City',
        ]),
      ],
    );

    // ── Step navigation ───────────────────────────────────────────────
    blocTest<StudentRegistrationBloc, StudentRegistrationState>(
      'NextStep triggers startRegistration at step 0',
      build: () {
        when(
          () => repo.startRegistration(phone: any(named: 'phone')),
        ).thenAnswer((_) async {});
        return buildBloc();
      },
      seed: () => const StudentRegistrationState(
        currentStep: 0,
        firstName: 'Kamal',
        phone: '01012345678',
        parentPhone: '01112345678',
      ),
      act: (bloc) => bloc.add(const StudentRegistrationNextStepRequested()),
      expect: () => [
        isA<StudentRegistrationState>().having(
          (s) => s.loadingState,
          'loading',
          LoadingState.loading,
        ),
        isA<StudentRegistrationState>().having((s) => s.currentStep, 'step', 1),
      ],
    );

    blocTest<StudentRegistrationBloc, StudentRegistrationState>(
      'NextStep advances from step 2 to 3 when valid',
      build: buildBloc,
      seed: () => const StudentRegistrationState(
        currentStep: 2,
        isRegistrationStarted: true,
        secondName: 'Ali',
        thirdName: 'Mohamed',
        fourthName: 'Hassan',
      ),
      act: (bloc) => bloc.add(const StudentRegistrationNextStepRequested()),
      expect: () => [
        isA<StudentRegistrationState>().having((s) => s.currentStep, 'step', 3),
      ],
    );

    blocTest<StudentRegistrationBloc, StudentRegistrationState>(
      'PreviousStep decrements step',
      build: buildBloc,
      seed: () => const StudentRegistrationState(currentStep: 3),
      act: (bloc) => bloc.add(const StudentRegistrationPreviousStepRequested()),
      expect: () => [
        isA<StudentRegistrationState>().having((s) => s.currentStep, 'step', 2),
      ],
    );

    blocTest<StudentRegistrationBloc, StudentRegistrationState>(
      'PreviousStep does nothing at step 0',
      build: buildBloc,
      seed: () => const StudentRegistrationState(currentStep: 0),
      act: (bloc) => bloc.add(const StudentRegistrationPreviousStepRequested()),
      expect: () => <StudentRegistrationState>[],
    );

    // ── Validation failures ───────────────────────────────────────────
    blocPresentationTest<
      StudentRegistrationBloc,
      StudentRegistrationState,
      StudentRegistrationPresentationEvent
    >(
      'emits validation failure when step 0 firstName is too short',
      build: buildBloc,
      seed: () => const StudentRegistrationState(
        currentStep: 0,
        firstName: 'K',
        phone: '01012345678',
        parentPhone: '01112345678',
      ),
      act: (bloc) => bloc.add(const StudentRegistrationStartRequested()),
      expectPresentation: () => [
        isA<StudentRegistrationFailurePresentationEvent>(),
      ],
    );

    blocPresentationTest<
      StudentRegistrationBloc,
      StudentRegistrationState,
      StudentRegistrationPresentationEvent
    >(
      'emits validation failure when step 0 phone equals parent phone',
      build: buildBloc,
      seed: () => const StudentRegistrationState(
        currentStep: 0,
        firstName: 'Kamal',
        phone: '01012345678',
        parentPhone: '01012345678', // same as student
      ),
      act: (bloc) => bloc.add(const StudentRegistrationStartRequested()),
      expectPresentation: () => [
        isA<StudentRegistrationFailurePresentationEvent>(),
      ],
    );

    // ── Complete Registration ─────────────────────────────────────────
    blocTest<StudentRegistrationBloc, StudentRegistrationState>(
      'completes registration with all valid data',
      build: () {
        when(
          () => repo.completeRegistration(
            firstName: any(named: 'firstName'),
            secondName: any(named: 'secondName'),
            thirdName: any(named: 'thirdName'),
            fourthName: any(named: 'fourthName'),
            governorateId: any(named: 'governorateId'),
            area: any(named: 'area'),
            gradeId: any(named: 'gradeId'),
            online: any(named: 'online'),
            otp: any(named: 'otp'),
            parentPhone: any(named: 'parentPhone'),
            phone: any(named: 'phone'),
            password: any(named: 'password'),
            confirmPassword: any(named: 'confirmPassword'),
            schoolName: any(named: 'schoolName'),
            educationDepartment: any(named: 'educationDepartment'),
            centerName: any(named: 'centerName'),
            profileImagePath: any(named: 'profileImagePath'),
            identityDocumentPath: any(named: 'identityDocumentPath'),
          ),
        ).thenAnswer(
          (_) async => const StudentRegistrationResponseEntity(
            studentCode: 'STU-123',
            status: 'pending',
          ),
        );
        return buildBloc();
      },
      seed: () => StudentRegistrationState(
        currentStep: 5,
        firstName: 'Kamal',
        secondName: 'Ayman',
        thirdName: 'Kamal',
        fourthName: 'Ayman',
        phone: '01012345678',
        parentPhone: '01112345678',
        otp: '123456',
        selectedGrade: const GradeEntity(id: '1', name: 'Grade 1'),
        selectedGovernorate: const GovernorateEntity(id: '1', name: 'Cairo'),
        selectedArea: 'Maadi',
        isOnline: true,
        password: 'Password123!',
        confirmPassword: 'Password123!',
      ),
      act: (bloc) => bloc.add(const StudentRegistrationSubmitted()),
      expect: () => [
        isA<StudentRegistrationState>().having(
          (s) => s.loadingState,
          'loading',
          LoadingState.loading,
        ),
        isA<StudentRegistrationState>().having(
          (s) => s.loadingState,
          'loaded',
          LoadingState.loaded,
        ),
      ],
    );

    blocTest<StudentRegistrationBloc, StudentRegistrationState>(
      'emits error when completeRegistration fails',
      build: () {
        when(
          () => repo.completeRegistration(
            firstName: any(named: 'firstName'),
            secondName: any(named: 'secondName'),
            thirdName: any(named: 'thirdName'),
            fourthName: any(named: 'fourthName'),
            governorateId: any(named: 'governorateId'),
            area: any(named: 'area'),
            gradeId: any(named: 'gradeId'),
            online: any(named: 'online'),
            otp: any(named: 'otp'),
            parentPhone: any(named: 'parentPhone'),
            phone: any(named: 'phone'),
            password: any(named: 'password'),
            confirmPassword: any(named: 'confirmPassword'),
            schoolName: any(named: 'schoolName'),
            educationDepartment: any(named: 'educationDepartment'),
            centerName: any(named: 'centerName'),
            profileImagePath: any(named: 'profileImagePath'),
            identityDocumentPath: any(named: 'identityDocumentPath'),
          ),
        ).thenThrow(Exception('Server error'));
        return buildBloc();
      },
      seed: () => StudentRegistrationState(
        currentStep: 5,
        firstName: 'Kamal',
        secondName: 'Ayman',
        thirdName: 'Kamal',
        fourthName: 'Ayman',
        phone: '01012345678',
        parentPhone: '01112345678',
        otp: '123456',
        selectedGrade: const GradeEntity(id: '1', name: 'Grade 1'),
        selectedGovernorate: const GovernorateEntity(id: '1', name: 'Cairo'),
        selectedArea: 'Maadi',
        isOnline: true,
        password: 'Password123!',
        confirmPassword: 'Password123!',
      ),
      act: (bloc) => bloc.add(const StudentRegistrationSubmitted()),
      expect: () => [
        isA<StudentRegistrationState>().having(
          (s) => s.loadingState,
          'loading',
          LoadingState.loading,
        ),
        isA<StudentRegistrationState>().having(
          (s) => s.loadingState,
          'error',
          LoadingState.error,
        ),
      ],
    );
  });
}
