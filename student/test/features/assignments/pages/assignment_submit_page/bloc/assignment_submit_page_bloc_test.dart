import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_assignment_repository/mock_assignment_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/assignments/pages/assignment_submit_page/bloc/assignment_submit_page_bloc.dart';

void main() {
  late MockAssignmentRepository assignmentRepository;

  setUp(() {
    assignmentRepository = const MockAssignmentRepository(delay: Duration.zero);
  });

  group('AssignmentSubmitPageBloc', () {
    blocTest<AssignmentSubmitPageBloc, AssignmentSubmitPageState>(
      'emits [loading, loaded] when load event is added',
      build: () => AssignmentSubmitPageBloc(
        assignmentRepository: assignmentRepository,
      ),
      act: (bloc) => bloc.add(const AssignmentSubmitPageLoadEvent()),
      expect: () => [
        isA<AssignmentSubmitPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<AssignmentSubmitPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );

    blocTest<AssignmentSubmitPageBloc, AssignmentSubmitPageState>(
      'initial state has LoadingState.initial',
      build: () => AssignmentSubmitPageBloc(
        assignmentRepository: assignmentRepository,
      ),
      verify: (bloc) {
        expect(bloc.state, AssignmentSubmitPageState.initial);
        expect(bloc.state.loadingState, LoadingState.initial);
      },
    );
  });
}
