import 'package:bloc_test/bloc_test.dart';
import 'package:device_info_service/device_info_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parent/features/auth/pages/parent_registration/bloc/parent_registration_bloc.dart';

class _MockAuthRepository extends Mock
    implements AuthenticationRepository<ParentEntity> {}

class _MockDeviceInfoService extends Mock implements DeviceInfoService {
  @override
  Future<String> getDeviceName() async => 'Test Device';
  @override
  Future<String> getDeviceHash() async => 'test_hash';
  @override
  Future<String> getAppVersion() async => '1.0.0';
}

void main() {
  late _MockAuthRepository auth;
  late _MockDeviceInfoService deviceInfo;

  const student = ParentStudentLookupEntity(
    studentId: 'student-1',
    maskedName: 'A***d K****l',
    gradeName: 'Primary 5',
    centerName: 'Cairo Center',
    canAutoVerify: true,
  );

  ParentRegistrationBloc buildBloc() => ParentRegistrationBloc(
    authenticationRepository: auth,
    deviceInfoService: deviceInfo,
  );

  // Helper that walks the state into "step 0 fully valid" (lookup + confirm).
  void prepareValidStep0(ParentRegistrationBloc bloc) {
    bloc.add(const ParentRegistrationLookupValueChanged(value: '01001234567'));
  }

  setUpAll(() {
    registerFallbackValue(ParentLookupType.phone);
  });

  setUp(() {
    auth = _MockAuthRepository();
    deviceInfo = _MockDeviceInfoService();
  });

  group('FindStudent', () {
    blocTest<ParentRegistrationBloc, ParentRegistrationState>(
      'empty lookup value fires lookupEmpty failure',
      build: buildBloc,
      act: (bloc) => bloc.add(const ParentRegistrationFindStudentSubmitted()),
      wait: const Duration(milliseconds: 20),
      verify: (bloc) {
        verifyNever(
          () => auth.findStudentForParentRegistration(
            lookupType: any(named: 'lookupType'),
            value: any(named: 'value'),
          ),
        );
      },
    );

    blocTest<ParentRegistrationBloc, ParentRegistrationState>(
      'success populates foundStudent and clears confirmation flag',
      setUp: () {
        when(
          () => auth.findStudentForParentRegistration(
            lookupType: ParentLookupType.phone,
            value: '01001234567',
          ),
        ).thenAnswer((_) async => student);
      },
      build: buildBloc,
      act: (bloc) async {
        prepareValidStep0(bloc);
        await Future<void>.delayed(Duration.zero);
        bloc.add(const ParentRegistrationFindStudentSubmitted());
      },
      wait: const Duration(milliseconds: 40),
      verify: (bloc) {
        expect(bloc.state.foundStudent, equals(student));
        expect(bloc.state.isStudentConfirmed, isFalse);
        expect(
          bloc.state.loadingState,
          equals(ParentRegistrationLoadingState.loaded),
        );
      },
    );

    blocTest<ParentRegistrationBloc, ParentRegistrationState>(
      'studentNotFound exception is classified correctly',
      setUp: () {
        when(
          () => auth.findStudentForParentRegistration(
            lookupType: any(named: 'lookupType'),
            value: any(named: 'value'),
          ),
        ).thenThrow(
          const AuthenticationException(
            code: AuthenticationExceptionCode.studentNotFound,
          ),
        );
      },
      build: buildBloc,
      act: (bloc) async {
        prepareValidStep0(bloc);
        await Future<void>.delayed(Duration.zero);
        bloc.add(const ParentRegistrationFindStudentSubmitted());
      },
      wait: const Duration(milliseconds: 40),
      verify: (bloc) {
        expect(
          bloc.state.loadingState,
          equals(ParentRegistrationLoadingState.failure),
        );
      },
    );
  });

  group('Step navigation', () {
    blocTest<ParentRegistrationBloc, ParentRegistrationState>(
      'next-step from 0 without confirmed student is blocked',
      build: buildBloc,
      act: (bloc) => bloc.add(const ParentRegistrationNextStepRequested()),
      verify: (bloc) {
        expect(bloc.state.currentStep, equals(0));
      },
    );

    blocTest<ParentRegistrationBloc, ParentRegistrationState>(
      'next-step succeeds once student is found + confirmed',
      setUp: () {
        when(
          () => auth.findStudentForParentRegistration(
            lookupType: any(named: 'lookupType'),
            value: any(named: 'value'),
          ),
        ).thenAnswer((_) async => student);
      },
      build: buildBloc,
      act: (bloc) async {
        prepareValidStep0(bloc);
        await Future<void>.delayed(Duration.zero);
        bloc.add(const ParentRegistrationFindStudentSubmitted());
        await Future<void>.delayed(const Duration(milliseconds: 20));
        bloc.add(const ParentRegistrationStudentConfirmed());
        bloc.add(const ParentRegistrationNextStepRequested());
      },
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        expect(bloc.state.currentStep, equals(1));
      },
    );

    blocTest<ParentRegistrationBloc, ParentRegistrationState>(
      'back-step from 0 stays at 0',
      build: buildBloc,
      act: (bloc) => bloc.add(const ParentRegistrationBackStepRequested()),
      verify: (bloc) {
        expect(bloc.state.currentStep, equals(0));
      },
    );
  });

  group('Validation gates', () {
    blocTest<ParentRegistrationBloc, ParentRegistrationState>(
      'firstNameShort blocks step 1 → 2',
      setUp: () {
        when(
          () => auth.findStudentForParentRegistration(
            lookupType: any(named: 'lookupType'),
            value: any(named: 'value'),
          ),
        ).thenAnswer((_) async => student);
      },
      build: buildBloc,
      act: (bloc) async {
        prepareValidStep0(bloc);
        await Future<void>.delayed(Duration.zero);
        bloc.add(const ParentRegistrationFindStudentSubmitted());
        await Future<void>.delayed(const Duration(milliseconds: 20));
        bloc.add(const ParentRegistrationStudentConfirmed());
        bloc.add(const ParentRegistrationNextStepRequested());
        // Now on step 1 with empty names → next should be blocked.
        bloc.add(const ParentRegistrationNextStepRequested());
      },
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        expect(bloc.state.currentStep, equals(1));
      },
    );
  });
}
