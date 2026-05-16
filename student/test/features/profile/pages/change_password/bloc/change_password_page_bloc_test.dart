import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_profile_repository/mock_profile_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/profile/pages/change_password/bloc/change_password_page_bloc.dart';

class MockAnalyticsService implements AnalyticsService {
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
  late AnalyticsService analyticsService;
  late MockProfileRepository profileRepository;

  setUp(() {
    analyticsService = MockAnalyticsService();
    profileRepository = const MockProfileRepository(delay: Duration.zero);
  });

  group('ChangePasswordPageBloc', () {
    blocTest<ChangePasswordPageBloc, ChangePasswordPageState>(
      'emits [loading, loaded] when load event is added',
      build: () => ChangePasswordPageBloc(profileRepository: profileRepository,
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const ChangePasswordPageLoadEvent()),
      expect: () => [
        isA<ChangePasswordPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<ChangePasswordPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );

    blocTest<ChangePasswordPageBloc, ChangePasswordPageState>(
      'starts with initial loading state',
      build: () => ChangePasswordPageBloc(profileRepository: profileRepository,
        analyticsService: analyticsService,
      ),
      verify: (bloc) {
        expect(bloc.state.loadingState, LoadingState.initial);
      },
    );
  });
}
