import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_assignment_repository/mock_assignment_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/assignments/pages/assignment_result_page/bloc/assignment_result_page_bloc.dart';

void main() {
  late MockAssignmentRepository assignmentRepository;

  setUp(() {
    assignmentRepository = const MockAssignmentRepository(delay: Duration.zero);
  });

  group('AssignmentResultPageBloc', () {
    blocTest<AssignmentResultPageBloc, AssignmentResultPageState>(
      'emits [loading, loaded] when load event is added',
      build: () => AssignmentResultPageBloc(
        assignmentRepository: assignmentRepository,
      ),
      act: (bloc) => bloc.add(const AssignmentResultPageLoadEvent()),
      expect: () => [
        isA<AssignmentResultPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<AssignmentResultPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );

    blocTest<AssignmentResultPageBloc, AssignmentResultPageState>(
      'initial state has LoadingState.initial',
      build: () => AssignmentResultPageBloc(
        assignmentRepository: assignmentRepository,
      ),
      verify: (bloc) {
        expect(bloc.state, AssignmentResultPageState.initial);
        expect(bloc.state.loadingState, LoadingState.initial);
      },
    );
  });
}
