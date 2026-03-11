import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_course_repository/mock_course_repository.dart';

import 'package:mentorx_student/features/course/pages/my_courses_page/bloc/my_courses_page_bloc.dart';

void main() {
  late MockCourseRepository courseRepository;

  setUp(() {
    courseRepository = const MockCourseRepository(delay: Duration.zero);
  });

  group('MyCoursesPageBloc', () {
    blocTest<MyCoursesPageBloc, MyCoursesPageState>(
      'emits [loading, loaded] when initialized',
      build: () => MyCoursesPageBloc(courseRepository: courseRepository),
      act: (bloc) => bloc.add(const MyCoursesPageInitialized()),
      expect: () => [
        isA<MyCoursesPageState>().having(
          (s) => s.status,
          'status',
          MyCoursesPageStatus.loading,
        ),
        isA<MyCoursesPageState>()
            .having((s) => s.status, 'status', MyCoursesPageStatus.loaded)
            .having((s) => s.courses.isNotEmpty, 'has courses', true),
      ],
    );

    blocTest<MyCoursesPageBloc, MyCoursesPageState>(
      'emits state with new tab when tab changed',
      build: () => MyCoursesPageBloc(courseRepository: courseRepository),
      seed: () => const MyCoursesPageState(
        status: MyCoursesPageStatus.loaded,
      ),
      act: (bloc) =>
          bloc.add(const MyCoursesPageTabChanged(MyCoursesTab.completed)),
      expect: () => [
        isA<MyCoursesPageState>()
            .having((s) => s.selectedTab, 'tab', MyCoursesTab.completed)
            .having((s) => s.status, 'status', MyCoursesPageStatus.loading),
        isA<MyCoursesPageState>()
            .having((s) => s.selectedTab, 'tab', MyCoursesTab.completed)
            .having((s) => s.status, 'status', MyCoursesPageStatus.loaded),
      ],
    );

    blocTest<MyCoursesPageBloc, MyCoursesPageState>(
      'loads expired courses when expired tab selected',
      build: () => MyCoursesPageBloc(courseRepository: courseRepository),
      seed: () => const MyCoursesPageState(
        status: MyCoursesPageStatus.loaded,
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
      build: () => MyCoursesPageBloc(courseRepository: courseRepository),
      seed: () => const MyCoursesPageState(
        status: MyCoursesPageStatus.loaded,
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
          (s) => s.status,
          'status',
          MyCoursesPageStatus.loading,
        ),
        // loaded with filtered results
        isA<MyCoursesPageState>()
            .having((s) => s.status, 'status', MyCoursesPageStatus.loaded)
            .having(
              (s) => s.courses.every(
                (c) => c.title.toLowerCase().contains('algebra'),
              ),
              'all contain algebra',
              true,
            ),
      ],
    );

    blocTest<MyCoursesPageBloc, MyCoursesPageState>(
      'refresh reloads courses',
      build: () => MyCoursesPageBloc(courseRepository: courseRepository),
      seed: () => const MyCoursesPageState(
        status: MyCoursesPageStatus.loaded,
        selectedTab: MyCoursesTab.inProgress,
      ),
      act: (bloc) => bloc.add(const MyCoursesPageRefreshed()),
      expect: () => [
        isA<MyCoursesPageState>().having(
          (s) => s.status,
          'status',
          MyCoursesPageStatus.loading,
        ),
        isA<MyCoursesPageState>().having(
          (s) => s.status,
          'status',
          MyCoursesPageStatus.loaded,
        ),
      ],
    );
  });
}
