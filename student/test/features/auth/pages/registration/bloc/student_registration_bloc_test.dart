import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/auth/pages/registration/bloc/student_registration_bloc.dart';

class MockStudentRegistrationRepository extends Mock
    implements StudentRegistrationRepository {}

void main() {
  late StudentRegistrationRepository registrationRepository;
  const tenantId = 'test-tenant';

  setUpAll(() {
    registerFallbackValue(const StudentRegistrationState());
  });

  setUp(() {
    registrationRepository = MockStudentRegistrationRepository();
    
    // Default mocks for lookups
    when(() => registrationRepository.getGovernorates())
        .thenAnswer((_) async => []);
    when(() => registrationRepository.getApplicationInfo())
        .thenAnswer((_) async => {'grades': []});
  });

  group('StudentRegistrationBloc', () {
    test('initial state is correct', () {
      final registrationBloc = StudentRegistrationBloc(
        registrationRepository: registrationRepository,
        tenantId: tenantId,
      );
      expect(registrationBloc.state, const StudentRegistrationState());
      registrationBloc.close();
    });

    blocTest<StudentRegistrationBloc, StudentRegistrationState>(
      'emits updated state when BootstrapRequested',
      build: () {
        when(() => registrationRepository.getGovernorates())
            .thenAnswer((_) async => [const GovernorateEntity(id: '1', name: 'Cairo')]);
        when(() => registrationRepository.getApplicationInfo())
            .thenAnswer((_) async => {
                  'grades': [{'id': '1', 'name': 'Grade 1'}]
                });
        return StudentRegistrationBloc(
          registrationRepository: registrationRepository,
          tenantId: tenantId,
        );
      },
      act: (StudentRegistrationBloc bloc) => bloc.add(const StudentRegistrationBootstrapRequested()),
      expect: () => [
        isA<StudentRegistrationState>().having(
          (StudentRegistrationState s) => s.governorates,
          'governorates',
          [const GovernorateEntity(id: '1', name: 'Cairo')],
        ).having(
          (StudentRegistrationState s) => s.grades,
          'grades',
          [const GradeEntity(id: '1', name: 'Grade 1')],
        ),
      ],
    );

    blocTest<StudentRegistrationBloc, StudentRegistrationState>(
      'moves to OTP step after successful startRegistration',
      build: () {
        when(() => registrationRepository.startRegistration(
          firstName: any(named: 'firstName'),
          phone: any(named: 'phone'),
          parentPhone: any(named: 'parentPhone'),
        )).thenAnswer((_) async => {});
        return StudentRegistrationBloc(
          registrationRepository: registrationRepository,
          tenantId: tenantId,
        );
      },
      seed: () => const StudentRegistrationState(
        firstName: 'Kamal',
        phone: '01012345678',
        parentPhone: '01112345678',
      ),
      act: (StudentRegistrationBloc bloc) => bloc.add(const StudentRegistrationStartRequested()),
      expect: () => [
        isA<StudentRegistrationState>().having((StudentRegistrationState s) => s.loadingState, 'loading', LoadingState.loading),
        isA<StudentRegistrationState>()
            .having((StudentRegistrationState s) => s.loadingState, 'loaded', LoadingState.loaded)
            .having((StudentRegistrationState s) => s.isRegistrationStarted, 'started', true)
            .having((StudentRegistrationState s) => s.currentStep, 'step', 1),
      ],
      verify: (_) {
        verify(() => registrationRepository.startRegistration(
          firstName: 'Kamal',
          phone: '01012345678',
          parentPhone: '01112345678',
        )).called(1);
      },
    );

    blocTest<StudentRegistrationBloc, StudentRegistrationState>(
      'emits failure presentation event when startRegistration fails',
      build: () {
        when(() => registrationRepository.startRegistration(
          firstName: any(named: 'firstName'),
          phone: any(named: 'phone'),
          parentPhone: any(named: 'parentPhone'),
        )).thenThrow(Exception('Failed to start'));
        return StudentRegistrationBloc(
          registrationRepository: registrationRepository,
          tenantId: tenantId,
        );
      },
      seed: () => const StudentRegistrationState(
        firstName: 'Kamal',
        phone: '01012345678',
        parentPhone: '01112345678',
      ),
      act: (StudentRegistrationBloc bloc) => bloc.add(const StudentRegistrationStartRequested()),
      expect: () => [
        isA<StudentRegistrationState>().having((StudentRegistrationState s) => s.loadingState, 'loading', LoadingState.loading),
        isA<StudentRegistrationState>()
            .having((StudentRegistrationState s) => s.loadingState, 'error', LoadingState.error)
            .having((StudentRegistrationState s) => s.errorMessage, 'error message', 'Exception: Failed to start'),
      ],
    );

    blocTest<StudentRegistrationBloc, StudentRegistrationState>(
      'completes registration successfully when all data is valid',
      build: () {
        when(() => registrationRepository.completeRegistration(
          firstName: any(named: 'firstName'),
          secondName: any(named: 'secondName'),
          thirdName: any(named: 'thirdName'),
          fourthName: any(named: 'fourthName'),
          governorate: any(named: 'governorate'),
          area: any(named: 'area'),
          grade: any(named: 'grade'),
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
        )).thenAnswer((_) async => {});
        return StudentRegistrationBloc(
          registrationRepository: registrationRepository,
          tenantId: tenantId,
        );
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
      act: (StudentRegistrationBloc bloc) => bloc.add(const StudentRegistrationSubmitted()),
      expect: () => [
        isA<StudentRegistrationState>().having((StudentRegistrationState s) => s.loadingState, 'loading', LoadingState.loading),
        isA<StudentRegistrationState>().having((StudentRegistrationState s) => s.loadingState, 'loaded', LoadingState.loaded),
      ],
      verify: (_) {
        verify(() => registrationRepository.completeRegistration(
          firstName: 'Kamal',
          secondName: 'Ayman',
          thirdName: 'Kamal',
          fourthName: 'Ayman',
          governorate: 'Cairo',
          area: 'Maadi',
          grade: 'Grade 1',
          online: true,
          otp: '123456',
          parentPhone: '01112345678',
          phone: '01012345678',
          password: 'Password123!',
          confirmPassword: 'Password123!',
        )).called(1);
      },
    );
  });
}
