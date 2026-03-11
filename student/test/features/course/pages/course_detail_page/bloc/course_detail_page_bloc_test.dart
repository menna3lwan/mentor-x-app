import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_course_repository/mock_course_repository.dart';

import 'package:mentorx_student/features/course/pages/course_detail_page/bloc/course_detail_page_bloc.dart';

void main() {
  late MockCourseRepository courseRepository;

  setUp(() {
    courseRepository = const MockCourseRepository(delay: Duration.zero);
  });

  group('CourseDetailPageBloc', () {
    blocTest<CourseDetailPageBloc, CourseDetailPageState>(
      'loads course, sessions, and items when initialized',
      build: () => CourseDetailPageBloc(
        courseRepository: courseRepository,
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
      },
    );

    blocTest<CourseDetailPageBloc, CourseDetailPageState>(
      'switches tab correctly',
      build: () => CourseDetailPageBloc(
        courseRepository: courseRepository,
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
      'enrolls successfully',
      build: () => CourseDetailPageBloc(
        courseRepository: courseRepository,
        courseId: 'cat1',
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
            .having((s) => s.enrollment, 'enrollment', isNotNull),
      ],
    );

    blocTest<CourseDetailPageBloc, CourseDetailPageState>(
      'returns null enrollment for non-enrolled course',
      build: () => CourseDetailPageBloc(
        courseRepository: courseRepository,
        courseId: 'cat5',
      ),
      act: (bloc) => bloc.add(const CourseDetailPageInitialized()),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        // cat5 doesn't start with 'ep' or 'ec', so no enrollment returned
        expect(bloc.state.enrollment, isNull);
      },
    );

    blocTest<CourseDetailPageBloc, CourseDetailPageState>(
      'refresh reloads all data',
      build: () => CourseDetailPageBloc(
        courseRepository: courseRepository,
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
      },
    );
  });
}
