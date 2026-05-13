import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parent/features/auth/pages/login/bloc/login_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:device_info_service/device_info_service.dart';
import 'package:analytics_service/analytics_service.dart';

class MockAuthRepository extends Mock implements AuthenticationRepository<ParentEntity> {}
class MockDeviceInfoService extends Mock implements DeviceInfoService {
  @override
  Future<String> getDeviceName() async => 'Test Device';
  @override
  Future<String> getDeviceHash() async => 'test_hash';
  @override
  Future<String> getAppVersion() async => '1.0.0';
}
class MockAnalyticsService extends Mock implements AnalyticsService {}

void main() {
  late MockAuthRepository authRepository;
  late MockDeviceInfoService deviceInfoService;
  late MockAnalyticsService analyticsService;

  const tPhone = '01000000000';
  const tPassword = 'password123';

  final tUser = ParentEntity(
    id: 'user-1',
    firstName: 'Test',
    lastName: 'Parent',
    email: 'test@parent.com',
    phoneNumber: tPhone,
    status: ParentStatus.active,
    createdAt: DateTime(2023),
    updatedAt: DateTime(2023),
  );

  setUp(() {
    authRepository = MockAuthRepository();
    deviceInfoService = MockDeviceInfoService();
    analyticsService = MockAnalyticsService();
    
    when(() => analyticsService.logEvent(
      name: any(named: 'name'),
      parameters: any(named: 'parameters'),
    )).thenAnswer((_) async => {});
  });

  group('LoginBloc', () {
    test('initial state is LoginState.initial', () {
      final bloc = LoginBloc(
        authenticationRepository: authRepository,
        deviceInfoService: deviceInfoService,
        analyticsService: analyticsService,
      );
      expect(bloc.state, LoginState.initial);
      bloc.close();
    });

    blocTest<LoginBloc, LoginState>(
      'emits [loading, success] on successful login',
      build: () {
        when(
          () => authRepository.login(
            phone: tPhone,
            password: tPassword,
            deviceName: any(named: 'deviceName'),
            deviceHash: any(named: 'deviceHash'),
            fcmToken: any(named: 'fcmToken'),
            appVersion: any(named: 'appVersion'),
          ),
        ).thenAnswer((_) async => tUser);
        return LoginBloc(
          authenticationRepository: authRepository,
          deviceInfoService: deviceInfoService,
          analyticsService: analyticsService,
        );
      },
      act: (bloc) => bloc.add(
        const LoginSubmittedEvent(
          phoneNumber: tPhone,
          password: tPassword,
        ),
      ),
      expect: () => [
        LoginState.initial.copyWith(loadingState: LoginLoadingState.loading),
        LoginState.initial.copyWith(loadingState: LoginLoadingState.success),
      ],
    );
  });
}
