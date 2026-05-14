import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_course_repository/mock_course_repository.dart';
import 'package:mentorx_student/core/core.dart';

import 'package:mentorx_student/features/course/pages/my_courses_page/bloc/my_courses_page_bloc.dart';

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
  late MockCourseRepository courseRepository;

  setUp(() {
    analyticsService = MockAnalyticsService();
    courseRepository = const MockCourseRepository(delay: Duration.zero);
  });

  group('MyCoursesPageBloc', () {
    blocTest<MyCoursesPageBloc, MyCoursesPageState>(
      'emits [loading, loaded] when initialized',
      build: () => MyCoursesPageBloc(courseRepository: courseRepository, analyticsService: analyticsService),
      act: (bloc) => bloc.add(const MyCoursesPageInitialized()),
      expect: () => [
        isA<MyCoursesPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<MyCoursesPageState>()
            .having((s) => s.loadingState, 'loadingState', LoadingState.loaded)
            .having((s) => s.courses.isNotEmpty, 'has courses', true),
      ],
    );

    blocTest<MyCoursesPageBloc, MyCoursesPageState>(
      'emits state with new tab when tab changed',
      build: () => MyCoursesPageBloc(courseRepository: courseRepository, analyticsService: analyticsService),
      seed: () => const MyCoursesPageState(
        loadingState: LoadingState.loaded,
      ),
      act: (bloc) =>
          bloc.add(const MyCoursesPageTabChanged(MyCoursesTab.completed)),
      expect: () => [
        isA<MyCoursesPageState>()
            .having((s) => s.selectedTab, 'tab', MyCoursesTab.completed)
            .having(
              (s) => s.loadingState,
              'loadingState',
              LoadingState.loading,
            ),
        isA<MyCoursesPageState>()
            .having((s) => s.selectedTab, 'tab', MyCoursesTab.completed)
            .having((s) => s.loadingState, 'loadingState', LoadingState.loaded),
      ],
    );

    blocTest<MyCoursesPageBloc, MyCoursesPageState>(
      'loads expired courses when expired tab selected',
      build: () => MyCoursesPageBloc(courseRepository: courseRepository, analyticsService: analyticsService),
      seed: () => const MyCoursesPageState(
        loadingState: LoadingState.loaded,
      ),
      act: (bloc) =>
          bloc.add(const MyCoursesPageTabChanged(MyCoursesTab.expired)),
      expect: () => [
        isA<MyCoursesPageState>().having(
          (s) => s.selectedTab,
          'tab',
          MyCoursesTab.expired,
        ),
        isA<MyCoursesPageState>()
            .having((s) => s.selectedTab, 'tab', MyCoursesTab.expired)
            .having((s) => s.courses.length, 'expired count', 2),
      ],
    );

    blocTest<MyCoursesPageBloc, MyCoursesPageState>(
      'search filters courses',
      build: () => MyCoursesPageBloc(courseRepository: courseRepository, analyticsService: analyticsService),
      seed: () => const MyCoursesPageState(
        loadingState: LoadingState.loaded,
      ),
      act: (bloc) => bloc.add(const MyCoursesPageSearchChanged('Algebra')),
      expect: () => [
        // searchQuery updated
        isA<MyCoursesPageState>().having(
          (s) => s.searchQuery,
          'query',
          'Algebra',
        ),
        // loading
        isA<MyCoursesPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        // loaded with filtered results
        isA<MyCoursesPageState>()
            .having((s) => s.loadingState, 'loadingState', LoadingState.loaded)
            .having(
              (s) => s.courses.every(
                (c) => (c.courseTitle ?? '').toLowerCase().contains('algebra'),
              ),
              'all contain algebra',
              true,
            ),
      ],
    );

    blocTest<MyCoursesPageBloc, MyCoursesPageState>(
      'refresh reloads courses',
      build: () => MyCoursesPageBloc(courseRepository: courseRepository, analyticsService: analyticsService),
      seed: () => const MyCoursesPageState(
        loadingState: LoadingState.loaded,
        selectedTab: MyCoursesTab.inProgress,
      ),
      act: (bloc) => bloc.add(const MyCoursesPageRefreshed()),
      expect: () => [
        isA<MyCoursesPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<MyCoursesPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );

    test('initial state has default values', () {
      final bloc = MyCoursesPageBloc(courseRepository: courseRepository, analyticsService: analyticsService);
      expect(bloc.state.loadingState, LoadingState.initial);
      expect(bloc.state.selectedTab, MyCoursesTab.inProgress);
      expect(bloc.state.courses, isEmpty);
      expect(bloc.state.searchQuery, '');
      expect(bloc.state.errorMessage, isNull);
      bloc.close();
    });

    test('inProgress tab is default', () {
      final bloc = MyCoursesPageBloc(courseRepository: courseRepository, analyticsService: analyticsService);
      expect(bloc.state.selectedTab, MyCoursesTab.inProgress);
      expect(bloc.state, equals(MyCoursesPageState.initial));
      bloc.close();
    });

    blocTest<MyCoursesPageBloc, MyCoursesPageState>(
      'clearing search loads all courses',
      build: () => MyCoursesPageBloc(courseRepository: courseRepository, analyticsService: analyticsService),
      seed: () => const MyCoursesPageState(
        loadingState: LoadingState.loaded,
        searchQuery: 'Algebra',
      ),
      act: (bloc) => bloc.add(const MyCoursesPageSearchChanged('')),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        expect(bloc.state.searchQuery, '');
        expect(bloc.state.loadingState, LoadingState.loaded);
        // Empty search returns all in_progress courses (unfiltered)
        expect(bloc.state.courses.isNotEmpty, true);
      },
    );
  });
}
