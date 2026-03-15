import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_assignment_repository/mock_assignment_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/assignments/pages/assignment_detail_page/bloc/assignment_detail_page_bloc.dart';

void main() {
  late MockAssignmentRepository assignmentRepository;

  setUp(() {
    assignmentRepository = const MockAssignmentRepository(delay: Duration.zero);
  });

  group('AssignmentDetailPageBloc', () {
    blocTest<AssignmentDetailPageBloc, AssignmentDetailPageState>(
      'emits [loading, loaded] when load event is added',
      build: () => AssignmentDetailPageBloc(
        assignmentRepository: assignmentRepository,
      ),
      act: (bloc) => bloc.add(const AssignmentDetailPageLoadEvent()),
      expect: () => [
        isA<AssignmentDetailPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<AssignmentDetailPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );

    blocTest<AssignmentDetailPageBloc, AssignmentDetailPageState>(
      'initial state has LoadingState.initial',
      build: () => AssignmentDetailPageBloc(
        assignmentRepository: assignmentRepository,
      ),
      verify: (bloc) {
        expect(bloc.state, AssignmentDetailPageState.initial);
        expect(bloc.state.loadingState, LoadingState.initial);
      },
    );
  });
}
