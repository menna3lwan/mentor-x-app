import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_assignment_repository/mock_assignment_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/assignments/pages/assignment_submit/bloc/assignment_submit_bloc.dart';

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
  late MockAssignmentRepository assignmentRepository;
  late _MockAnalyticsService analyticsService;
  const testId = 'assignment-123';

  setUp(() {
    assignmentRepository = const MockAssignmentRepository(delay: Duration.zero);
    analyticsService = _MockAnalyticsService();
  });

  group('AssignmentSubmitBloc', () {
    blocTest<AssignmentSubmitBloc, AssignmentSubmitState>(
      'emits [loading, loaded] when load event is added',
      build: () => AssignmentSubmitBloc(
        assignmentRepository: assignmentRepository,
        analyticsService: analyticsService,
        assignmentId: testId,
      ),
      act: (bloc) => bloc.add(const AssignmentSubmitLoadEvent()),
      expect: () => [
        isA<AssignmentSubmitState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<AssignmentSubmitState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );

    blocTest<AssignmentSubmitBloc, AssignmentSubmitState>(
      'initial state is correct',
      build: () => AssignmentSubmitBloc(
        assignmentRepository: assignmentRepository,
        analyticsService: analyticsService,
        assignmentId: testId,
      ),
      verify: (bloc) {
        expect(bloc.state.assignmentId, testId);
        expect(bloc.state.loadingState, LoadingState.initial);
      },
    );
  });
}
