import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_assignment_repository/mock_assignment_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/assignments/pages/assignment_result/bloc/assignment_result_page_bloc.dart';

class MockAnalyticsService implements AnalyticsService {
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
  late AnalyticsService analyticsService;
  late MockAssignmentRepository assignmentRepository;

  setUp(() {
    analyticsService = MockAnalyticsService();
    assignmentRepository = const MockAssignmentRepository(delay: Duration.zero);
  });

  group('AssignmentResultPageBloc', () {
    blocTest<AssignmentResultPageBloc, AssignmentResultPageState>(
      'emits [loading, loaded] when load event is added',
      build: () => AssignmentResultPageBloc(
        assignmentRepository: assignmentRepository,
        analyticsService: analyticsService,
        assignmentId: 'dummy-id',
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
        analyticsService: analyticsService,
        assignmentId: 'dummy-id',
      ),
      verify: (bloc) {
        expect(bloc.state, const AssignmentResultPageState(assignmentId: 'dummy-id'));
        expect(bloc.state.loadingState, LoadingState.initial);
      },
    );
  });
}
