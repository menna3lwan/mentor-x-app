import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_profile_repository/mock_profile_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/profile/pages/edit_profile_page/bloc/edit_profile_page_bloc.dart';

void main() {
  late MockProfileRepository profileRepository;

  setUp(() {
    profileRepository = const MockProfileRepository(delay: Duration.zero);
  });

  group('EditProfilePageBloc', () {
    blocTest<EditProfilePageBloc, EditProfilePageState>(
      'emits [loading, loaded] when load event is added',
      build: () => EditProfilePageBloc(
        profileRepository: profileRepository,
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
      ),
      verify: (bloc) {
        expect(bloc.state.loadingState, LoadingState.initial);
      },
    );
  });
}
