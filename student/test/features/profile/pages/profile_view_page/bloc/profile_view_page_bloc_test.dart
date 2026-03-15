import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_profile_repository/mock_profile_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/profile/pages/profile_view_page/bloc/profile_view_page_bloc.dart';

void main() {
  late MockProfileRepository profileRepository;

  setUp(() {
    profileRepository = const MockProfileRepository(delay: Duration.zero);
  });

  group('ProfileViewPageBloc', () {
    blocTest<ProfileViewPageBloc, ProfileViewPageState>(
      'emits [loading, loaded] when load event is added',
      build: () => ProfileViewPageBloc(
        profileRepository: profileRepository,
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
      ),
      verify: (bloc) {
        expect(bloc.state.loadingState, LoadingState.initial);
      },
    );
  });
}
