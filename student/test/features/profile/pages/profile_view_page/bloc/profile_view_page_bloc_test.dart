import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_profile_repository/mock_profile_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/profile/pages/profile_view_page/bloc/profile_view_page_bloc.dart';

class _MockAnalyticsService implements AnalyticsService {
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
  late MockProfileRepository profileRepository;
  late _MockAnalyticsService analyticsService;

  setUp(() {
    profileRepository = const MockProfileRepository(delay: Duration.zero);
    analyticsService = _MockAnalyticsService();
  });

  group('ProfileViewPageBloc', () {
    blocTest<ProfileViewPageBloc, ProfileViewPageState>(
      'emits [loading, loaded] when load event is added',
      build: () => ProfileViewPageBloc(
        profileRepository: profileRepository,
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const ProfileViewPageLoadEvent()),
      expect: () => [
        isA<ProfileViewPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<ProfileViewPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );

    blocTest<ProfileViewPageBloc, ProfileViewPageState>(
      'starts with initial loading state',
      build: () => ProfileViewPageBloc(
        profileRepository: profileRepository,
        analyticsService: analyticsService,
      ),
      verify: (bloc) {
        expect(bloc.state.loadingState, LoadingState.initial);
      },
    );
  });
}
