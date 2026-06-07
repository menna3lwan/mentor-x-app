import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_assignment_repository/mock_assignment_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/assignments/pages/assignment_detail/bloc/assignment_detail_bloc.dart';

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

  group('AssignmentDetailBloc', () {
    blocTest<AssignmentDetailBloc, AssignmentDetailState>(
      'emits [loading, loaded] when load event is added',
      build: () => AssignmentDetailBloc(assignmentRepository: assignmentRepository,
        analyticsService: analyticsService,
      ),
      act: (bloc) =>
          bloc.add(const AssignmentDetailLoadEvent(assignmentId: '1')),
      wait: Duration.zero,
      expect: () => [
        isA<AssignmentDetailState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<AssignmentDetailState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );

    blocTest<AssignmentDetailBloc, AssignmentDetailState>(
      'initial state has LoadingState.initial',
      build: () => AssignmentDetailBloc(assignmentRepository: assignmentRepository,
        analyticsService: analyticsService,
      ),
      verify: (bloc) {
        expect(bloc.state, AssignmentDetailState.initial);
        expect(bloc.state.loadingState, LoadingState.initial);
      },
    );
  });
}
