import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_course_repository/mock_course_repository.dart';

import 'package:mentorx_student/features/course/pages/course_catalog_page/bloc/course_catalog_page_bloc.dart';
import 'package:mock_student_registration_repository/mock_student_registration_repository.dart';

void main() {
  late MockCourseRepository courseRepository;
  late MockStudentRegistrationRepository registrationRepository;

  setUp(() {
    courseRepository = const MockCourseRepository(delay: Duration.zero);
    registrationRepository = const MockStudentRegistrationRepository(
      delay: Duration.zero,
    );
  });

  group('CourseCatalogPageBloc', () {
    blocTest<CourseCatalogPageBloc, CourseCatalogPageState>(
      'loads categories and courses when initialized',
      build: () => CourseCatalogPageBloc(
        courseRepository: courseRepository,
        registrationRepository: registrationRepository,
      ),
      act: (bloc) => bloc.add(const CourseCatalogPageInitialized()),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        expect(bloc.state.categoriesStatus, CatalogSectionStatus.loaded);
        expect(bloc.state.categories.isNotEmpty, true);
        expect(bloc.state.coursesStatus, CatalogSectionStatus.loaded);
        expect(bloc.state.courses.isNotEmpty, true);
      },
    );

    blocTest<CourseCatalogPageBloc, CourseCatalogPageState>(
      'changes sort option and reloads courses',
      build: () => CourseCatalogPageBloc(
        courseRepository: courseRepository,
        registrationRepository: registrationRepository,
      ),
      seed: () => const CourseCatalogPageState(
        coursesStatus: CatalogSectionStatus.loaded,
      ),
      act: (bloc) => bloc.add(
        const CourseCatalogPageSortChanged(CatalogSortOption.priceAsc),
      ),
      expect: () => [
        // sortOption updated
        isA<CourseCatalogPageState>()
            .having((s) => s.sortOption, 'sort', CatalogSortOption.priceAsc)
            .having(
              (s) => s.coursesStatus,
              'status',
              CatalogSectionStatus.loaded,
            ),
        // courses loading
        isA<CourseCatalogPageState>()
            .having((s) => s.sortOption, 'sort', CatalogSortOption.priceAsc)
            .having(
              (s) => s.coursesStatus,
              'status',
              CatalogSectionStatus.loading,
            ),
        // courses loaded
        isA<CourseCatalogPageState>()
            .having((s) => s.sortOption, 'sort', CatalogSortOption.priceAsc)
            .having(
              (s) => s.coursesStatus,
              'status',
              CatalogSectionStatus.loaded,
            )
            .having((s) => s.courses.isNotEmpty, 'has courses', true),
      ],
    );

    blocTest<CourseCatalogPageBloc, CourseCatalogPageState>(
      'search updates query and reloads',
      build: () => CourseCatalogPageBloc(
        courseRepository: courseRepository,
        registrationRepository: registrationRepository,
      ),
      seed: () => const CourseCatalogPageState(
        coursesStatus: CatalogSectionStatus.loaded,
      ),
      act: (bloc) =>
          bloc.add(const CourseCatalogPageSearchChanged('Chemistry')),
      expect: () => [
        // searchQuery updated
        isA<CourseCatalogPageState>().having(
          (s) => s.searchQuery,
          'query',
          'Chemistry',
        ),
        // courses loading
        isA<CourseCatalogPageState>().having(
          (s) => s.coursesStatus,
          'status',
          CatalogSectionStatus.loading,
        ),
        // courses loaded filtered
        isA<CourseCatalogPageState>()
            .having(
              (s) => s.coursesStatus,
              'status',
              CatalogSectionStatus.loaded,
            )
            .having(
              (s) => s.courses.every(
                (c) => c.title.toLowerCase().contains('chemistry'),
              ),
              'filtered by chemistry',
              true,
            ),
      ],
    );

    blocTest<CourseCatalogPageBloc, CourseCatalogPageState>(
      'category selection filters courses',
      build: () => CourseCatalogPageBloc(
        courseRepository: courseRepository,
        registrationRepository: registrationRepository,
      ),
      seed: () => const CourseCatalogPageState(
        coursesStatus: CatalogSectionStatus.loaded,
      ),
      act: (bloc) =>
          bloc.add(const CourseCatalogPageCategoryChanged('cat_math')),
      expect: () => [
        // categoryId updated
        isA<CourseCatalogPageState>()
            .having((s) => s.selectedCategoryId, 'cat', 'cat_math')
            .having(
              (s) => s.coursesStatus,
              'status',
              CatalogSectionStatus.loaded,
            ),
        // courses loading
        isA<CourseCatalogPageState>()
            .having((s) => s.selectedCategoryId, 'cat', 'cat_math')
            .having(
              (s) => s.coursesStatus,
              'status',
              CatalogSectionStatus.loading,
            ),
        // courses loaded
        isA<CourseCatalogPageState>()
            .having((s) => s.selectedCategoryId, 'cat', 'cat_math')
            .having(
              (s) => s.coursesStatus,
              'status',
              CatalogSectionStatus.loaded,
            )
            .having((s) => s.courses.isNotEmpty, 'has courses', true),
      ],
    );

    blocTest<CourseCatalogPageBloc, CourseCatalogPageState>(
      'refresh reloads courses',
      build: () => CourseCatalogPageBloc(
        courseRepository: courseRepository,
        registrationRepository: registrationRepository,
      ),
      seed: () => const CourseCatalogPageState(
        coursesStatus: CatalogSectionStatus.loaded,
      ),
      act: (bloc) => bloc.add(const CourseCatalogPageRefreshed()),
      expect: () => [
        // courses loading
        isA<CourseCatalogPageState>().having(
          (s) => s.coursesStatus,
          'status',
          CatalogSectionStatus.loading,
        ),
        // courses loaded
        isA<CourseCatalogPageState>()
            .having(
              (s) => s.coursesStatus,
              'status',
              CatalogSectionStatus.loaded,
            )
            .having((s) => s.courses.isNotEmpty, 'has courses', true),
      ],
    );

    test('initial state has default values', () {
      final bloc = CourseCatalogPageBloc(
        courseRepository: courseRepository,
        registrationRepository: registrationRepository,
      );
      expect(bloc.state.coursesStatus, CatalogSectionStatus.initial);
      expect(bloc.state.categoriesStatus, CatalogSectionStatus.initial);
      expect(bloc.state.courses, isEmpty);
      expect(bloc.state.categories, isEmpty);
      expect(bloc.state.searchQuery, '');
      expect(bloc.state.selectedCategoryId, isNull);
      expect(bloc.state.sortOption, CatalogSortOption.newest);
      expect(bloc.state.errorMessage, isNull);
      bloc.close();
    });

    blocTest<CourseCatalogPageBloc, CourseCatalogPageState>(
      'clearing category resets to null',
      build: () => CourseCatalogPageBloc(
        courseRepository: courseRepository,
        registrationRepository: registrationRepository,
      ),
      seed: () => const CourseCatalogPageState(
        coursesStatus: CatalogSectionStatus.loaded,
        selectedCategoryId: 'cat_math',
      ),
      act: (bloc) => bloc.add(const CourseCatalogPageCategoryChanged(null)),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        expect(bloc.state.selectedCategoryId, isNull);
        expect(bloc.state.coursesStatus, CatalogSectionStatus.loaded);
        expect(bloc.state.courses.isNotEmpty, true);
      },
    );

    blocTest<CourseCatalogPageBloc, CourseCatalogPageState>(
      'search with empty string loads all courses',
      build: () => CourseCatalogPageBloc(
        courseRepository: courseRepository,
        registrationRepository: registrationRepository,
      ),
      seed: () => const CourseCatalogPageState(
        coursesStatus: CatalogSectionStatus.loaded,
        searchQuery: 'Chemistry',
      ),
      act: (bloc) => bloc.add(const CourseCatalogPageSearchChanged('')),
      wait: const Duration(milliseconds: 50),
      verify: (bloc) {
        expect(bloc.state.searchQuery, '');
        expect(bloc.state.coursesStatus, CatalogSectionStatus.loaded);
        // Empty search returns all catalog courses (unfiltered)
        expect(bloc.state.courses.isNotEmpty, true);
      },
    );
  });
}
