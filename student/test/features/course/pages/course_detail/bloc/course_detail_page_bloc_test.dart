import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_course_repository/mock_course_repository.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/course/pages/course_detail/bloc/course_detail_page_bloc.dart';

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
  late MockCourseRepository courseRepository;
  late MockAnalyticsService analyticsService;

  setUp(() {
    courseRepository = const MockCourseRepository(delay: Duration.zero);
    analyticsService = MockAnalyticsService();

  });

  group('CourseDetailPageBloc', () {
    test('initial state has correct defaults', () {
      final bloc = CourseDetailPageBloc(
        courseRepository: courseRepository,
        analyticsService: analyticsService,
        courseId: 'ep1',
      );
      expect(bloc.state.courseId, 'ep1');
      expect(bloc.state.courseStatus, DetailSectionStatus.initial);
      expect(bloc.state.sessionsStatus, DetailSectionStatus.initial);
      expect(bloc.state.course, isNull);
      expect(bloc.state.sessions, isEmpty);
      expect(bloc.state.sessionItems, isEmpty);
      expect(bloc.state.enrollment, isNull);
      expect(bloc.state.selectedTab, CourseDetailTab.description);
      expect(bloc.state.enrollStatus, EnrollActionStatus.initial);
      expect(bloc.state.errorMessage, isNull);
      expect(bloc.state.enrollErrorMessage, isNull);
      expect(bloc.state.isEnrolled, false);
      expect(bloc.state.isEnrolling, false);
      bloc.close();
    });

    blocTest<CourseDetailPageBloc, CourseDetailPageState>(
      'loads course, sessions, and items when initialized',
      build: () => CourseDetailPageBloc(
        courseRepository: courseRepository,
        analyticsService: analyticsService,
        courseId: 'ep1',
      ),
      act: (bloc) => bloc.add(const CourseDetailPageInitialized()),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        expect(bloc.state.courseStatus, DetailSectionStatus.loaded);
        expect(bloc.state.course, isNotNull);
        expect(bloc.state.course!.title, isNotEmpty);
        expect(bloc.state.sessionsStatus, DetailSectionStatus.loaded);
        expect(bloc.state.sessions, isNotEmpty);
        expect(bloc.state.sessionItems, isNotEmpty);
        // ep1 starts with 'ep' so progress should be returned
        expect(bloc.state.enrollment, isNotNull);
        expect(bloc.state.isEnrolled, true);
      },
    );

    blocTest<CourseDetailPageBloc, CourseDetailPageState>(
      'switches tab to sessions correctly',
      build: () => CourseDetailPageBloc(
        courseRepository: courseRepository,
        analyticsService: analyticsService,
        courseId: 'ep1',
      ),
      act: (bloc) =>
          bloc.add(const CourseDetailPageTabChanged(CourseDetailTab.sessions)),
      expect: () => [
        isA<CourseDetailPageState>().having(
          (s) => s.selectedTab,
          'tab',
          CourseDetailTab.sessions,
        ),
      ],
    );

    blocTest<CourseDetailPageBloc, CourseDetailPageState>(
      'switches tab back to description',
      build: () => CourseDetailPageBloc(
        courseRepository: courseRepository,
        analyticsService: analyticsService,
        courseId: 'ep1',
      ),
      seed: () => CourseDetailPageState(
        courseId: 'ep1',
        selectedTab: CourseDetailTab.sessions,
      ),
      act: (bloc) => bloc.add(
        const CourseDetailPageTabChanged(CourseDetailTab.description),
      ),
      expect: () => [
        isA<CourseDetailPageState>().having(
          (s) => s.selectedTab,
          'tab',
          CourseDetailTab.description,
        ),
      ],
    );

    blocTest<CourseDetailPageBloc, CourseDetailPageState>(
      'enrolls successfully',
      build: () => CourseDetailPageBloc(
        courseRepository: courseRepository,
        analyticsService: analyticsService,
        courseId: 'ep1',
      ),
      seed: () => CourseDetailPageState(
        courseId: 'cat1',
        courseStatus: DetailSectionStatus.loaded,
      ),
      act: (bloc) => bloc.add(const CourseDetailPageEnrollRequested()),
      expect: () => [
        isA<CourseDetailPageState>().having(
          (s) => s.enrollStatus,
          'enrollStatus',
          EnrollActionStatus.loading,
        ),
        isA<CourseDetailPageState>()
            .having(
              (s) => s.enrollStatus,
              'enrollStatus',
              EnrollActionStatus.success,
            )
            .having((s) => s.enrollment, 'enrollment', isNotNull)
            .having((s) => s.isEnrolled, 'isEnrolled', true)
            .having((s) => s.isEnrollSuccess, 'isEnrollSuccess', true),
      ],
    );

    blocTest<CourseDetailPageBloc, CourseDetailPageState>(
      'returns null enrollment for non-enrolled course',
      build: () => CourseDetailPageBloc(
        courseRepository: courseRepository,
        analyticsService: analyticsService,
        courseId: 'test1',
      ),
      act: (bloc) => bloc.add(const CourseDetailPageInitialized()),
      wait: const Duration(milliseconds: 100),
      verify: (bloc) {
        // test1 doesn't start with 'ep' or 'ec', so no enrollment returned
        expect(bloc.state.enrollment, isNull);
        expect(bloc.state.isEnrolled, false);
      },
    );

    blocTest<CourseDetailPageBloc, CourseDetailPageState>(
      'refresh reloads all data',
      build: () => CourseDetailPageBloc(
        courseRepository: courseRepository,
        analyticsService: analyticsService,
        courseId: 'ep1',
      ),
      seed: () => CourseDetailPageState(
        courseId: 'ep1',
        courseStatus: DetailSectionStatus.loaded,
        sessionsStatus: DetailSectionStatus.loaded,
      ),
      act: (bloc) => bloc.add(const CourseDetailPageRefreshed()),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        expect(bloc.state.courseStatus, DetailSectionStatus.loaded);
        expect(bloc.state.sessionsStatus, DetailSectionStatus.loaded);
        expect(bloc.state.course, isNotNull);
        expect(bloc.state.sessions, isNotEmpty);
        expect(bloc.state.sessionItems, isNotEmpty);
      },
    );

    blocTest<CourseDetailPageBloc, CourseDetailPageState>(
      'enrollment with ec prefix returns enrollment',
      build: () => CourseDetailPageBloc(
        courseRepository: courseRepository,
        analyticsService: analyticsService,
        courseId: 'ep1',
      ),
      act: (bloc) => bloc.add(const CourseDetailPageInitialized()),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        // ec1 starts with 'ec', so enrollment should be returned
        expect(bloc.state.enrollment, isNotNull);
        expect(bloc.state.isEnrolled, true);
      },
    );

    blocTest<CourseDetailPageBloc, CourseDetailPageState>(
      'sessions have correct items loaded',
      build: () => CourseDetailPageBloc(
        courseRepository: courseRepository,
        analyticsService: analyticsService,
        courseId: 'ep1',
      ),
      act: (bloc) => bloc.add(const CourseDetailPageInitialized()),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        expect(bloc.state.sessions, isNotEmpty);
        // Each session should have item entries in the map
        for (final session in bloc.state.sessions) {
          expect(
            bloc.state.sessionItems.containsKey(session.id),
            true,
            reason: 'Session ${session.id} should have items',
          );
        }
      },
    );

    test('state getters reflect correct values', () {
      const state = CourseDetailPageState(courseId: 'test');
      expect(state.isCourseLoading, true); // initial is treated as loading
      expect(state.isCourseLoaded, false);
      expect(state.isCourseFailure, false);
      expect(state.isSessionsLoading, true); // initial is treated as loading
      expect(state.isEnrolled, false);
      expect(state.isEnrolling, false);
      expect(state.isEnrollSuccess, false);
      expect(state.isEnrollFailure, false);

      final loadedState = state.copyWith(
        courseStatus: DetailSectionStatus.loaded,
        sessionsStatus: DetailSectionStatus.loaded,
      );
      expect(loadedState.isCourseLoading, false);
      expect(loadedState.isCourseLoaded, true);
      expect(loadedState.isSessionsLoading, false);

      final failureState = state.copyWith(
        courseStatus: DetailSectionStatus.failure,
      );
      expect(failureState.isCourseFailure, true);
      expect(failureState.isCourseLoaded, false);
    });
  });
}
