import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_course_repository/mock_course_repository.dart';
import 'package:mentorx_student/core/core.dart';

import 'package:mentorx_student/features/course/pages/my_courses/bloc/my_courses_bloc.dart';

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

  group('MyCoursesBloc', () {
    blocTest<MyCoursesBloc, MyCoursesState>(
      'emits [loading, loaded] when initialized',
      build: () => MyCoursesBloc(courseRepository: courseRepository, analyticsService: analyticsService),
      act: (bloc) => bloc.add(const MyCoursesInitialized()),
      expect: () => [
        isA<MyCoursesState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<MyCoursesState>()
            .having((s) => s.loadingState, 'loadingState', LoadingState.loaded)
            .having((s) => s.courses.isNotEmpty, 'has courses', true),
      ],
    );

    blocTest<MyCoursesBloc, MyCoursesState>(
      'emits state with new tab when tab changed',
      build: () => MyCoursesBloc(courseRepository: courseRepository, analyticsService: analyticsService),
      seed: () => const MyCoursesState(
        loadingState: LoadingState.loaded,
      ),
      act: (bloc) =>
          bloc.add(const MyCoursesTabChanged(MyCoursesTab.completed)),
      expect: () => [
        isA<MyCoursesState>()
            .having((s) => s.selectedTab, 'tab', MyCoursesTab.completed)
            .having(
              (s) => s.loadingState,
              'loadingState',
              LoadingState.loading,
            ),
        isA<MyCoursesState>()
            .having((s) => s.selectedTab, 'tab', MyCoursesTab.completed)
            .having((s) => s.loadingState, 'loadingState', LoadingState.loaded),
      ],
    );

    blocTest<MyCoursesBloc, MyCoursesState>(
      'loads expired courses when expired tab selected',
      build: () => MyCoursesBloc(courseRepository: courseRepository, analyticsService: analyticsService),
      seed: () => const MyCoursesState(
        loadingState: LoadingState.loaded,
      ),
      act: (bloc) =>
          bloc.add(const MyCoursesTabChanged(MyCoursesTab.expired)),
      expect: () => [
        isA<MyCoursesState>().having(
          (s) => s.selectedTab,
          'tab',
          MyCoursesTab.expired,
        ),
        isA<MyCoursesState>()
            .having((s) => s.selectedTab, 'tab', MyCoursesTab.expired)
            .having((s) => s.courses.length, 'expired count', 2),
      ],
    );

    blocTest<MyCoursesBloc, MyCoursesState>(
      'search filters courses',
      build: () => MyCoursesBloc(courseRepository: courseRepository, analyticsService: analyticsService),
      seed: () => const MyCoursesState(
        loadingState: LoadingState.loaded,
      ),
      act: (bloc) => bloc.add(const MyCoursesSearchChanged('Algebra')),
      expect: () => [
        // searchQuery updated
        isA<MyCoursesState>().having(
          (s) => s.searchQuery,
          'query',
          'Algebra',
        ),
        // loading
        isA<MyCoursesState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        // loaded with filtered results
        isA<MyCoursesState>()
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

    blocTest<MyCoursesBloc, MyCoursesState>(
      'refresh reloads courses',
      build: () => MyCoursesBloc(courseRepository: courseRepository, analyticsService: analyticsService),
      seed: () => const MyCoursesState(
        loadingState: LoadingState.loaded,
        selectedTab: MyCoursesTab.inProgress,
      ),
      act: (bloc) => bloc.add(const MyCoursesRefreshed()),
      expect: () => [
        isA<MyCoursesState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<MyCoursesState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );

    test('initial state has default values', () {
      final bloc = MyCoursesBloc(courseRepository: courseRepository, analyticsService: analyticsService);
      expect(bloc.state.loadingState, LoadingState.initial);
      expect(bloc.state.selectedTab, MyCoursesTab.inProgress);
      expect(bloc.state.courses, isEmpty);
      expect(bloc.state.searchQuery, '');
      expect(bloc.state.errorMessage, isNull);
      bloc.close();
    });

    test('inProgress tab is default', () {
      final bloc = MyCoursesBloc(courseRepository: courseRepository, analyticsService: analyticsService);
      expect(bloc.state.selectedTab, MyCoursesTab.inProgress);
      expect(bloc.state, equals(MyCoursesState.initial));
      bloc.close();
    });

    blocTest<MyCoursesBloc, MyCoursesState>(
      'clearing search loads all courses',
      build: () => MyCoursesBloc(courseRepository: courseRepository, analyticsService: analyticsService),
      seed: () => const MyCoursesState(
        loadingState: LoadingState.loaded,
        searchQuery: 'Algebra',
      ),
      act: (bloc) => bloc.add(const MyCoursesSearchChanged('')),
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
