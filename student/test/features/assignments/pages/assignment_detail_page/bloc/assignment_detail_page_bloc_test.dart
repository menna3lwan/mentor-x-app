import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_assignment_repository/mock_assignment_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/assignments/pages/assignment_detail_page/bloc/assignment_detail_page_bloc.dart';

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

  group('AssignmentDetailPageBloc', () {
    blocTest<AssignmentDetailPageBloc, AssignmentDetailPageState>(
      'emits [loading, loaded] when load event is added',
      build: () => AssignmentDetailPageBloc(assignmentRepository: assignmentRepository,
        analyticsService: analyticsService,
      ),
      act: (bloc) =>
          bloc.add(const AssignmentDetailPageLoadEvent(assignmentId: '1')),
      wait: Duration.zero,
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
      build: () => AssignmentDetailPageBloc(assignmentRepository: assignmentRepository,
        analyticsService: analyticsService,
      ),
      verify: (bloc) {
        expect(bloc.state, AssignmentDetailPageState.initial);
        expect(bloc.state.loadingState, LoadingState.initial);
      },
    );
  });
}
