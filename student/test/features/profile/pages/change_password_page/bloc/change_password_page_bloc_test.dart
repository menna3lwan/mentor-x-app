import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_profile_repository/mock_profile_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/profile/pages/change_password_page/bloc/change_password_page_bloc.dart';

class MockAnalyticsService extends Mock implements AnalyticsService {}


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
