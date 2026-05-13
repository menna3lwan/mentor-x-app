import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_assignment_repository/mock_assignment_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/assignments/pages/assignment_result_page/bloc/assignment_result_page_bloc.dart';

class MockAnalyticsService extends Mock implements AnalyticsService {}


void main() {
  late AnalyticsService analyticsService;
  late MockAssignmentRepository assignmentRepository;

  setUp(() {
    analyticsService = MockAnalyticsService();
    assignmentRepository = const MockAssignmentRepository(delay: Duration.zero);
  });

  group('AssignmentResultPageBloc', () {
    blocTest<AssignmentResultPageBloc, AssignmentResultPageState>(
      'emits [loading, loaded] when load event is added',
      build: () => AssignmentResultPageBloc(assignmentRepository: assignmentRepository,
        analyticsService: analyticsService,
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
      build: () => AssignmentResultPageBloc(assignmentRepository: assignmentRepository,
        analyticsService: analyticsService,
      ),
      verify: (bloc) {
        expect(bloc.state, AssignmentResultPageState.initial);
        expect(bloc.state.loadingState, LoadingState.initial);
      },
    );
  });
}
