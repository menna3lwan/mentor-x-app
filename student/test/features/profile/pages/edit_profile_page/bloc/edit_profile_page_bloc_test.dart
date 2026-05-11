import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_profile_repository/mock_profile_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/profile/pages/edit_profile_page/bloc/edit_profile_page_bloc.dart';

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

  group('EditProfilePageBloc', () {
    blocTest<EditProfilePageBloc, EditProfilePageState>(
      'emits [loading, loaded] when load event is added',
      build: () => EditProfilePageBloc(
        profileRepository: profileRepository,
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const EditProfilePageLoadEvent()),
      expect: () => [
        isA<EditProfilePageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<EditProfilePageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );

    blocTest<EditProfilePageBloc, EditProfilePageState>(
      'starts with initial loading state',
      build: () => EditProfilePageBloc(
        profileRepository: profileRepository,
        analyticsService: analyticsService,
      ),
      verify: (bloc) {
        expect(bloc.state.loadingState, LoadingState.initial);
      },
    );
  });
}
