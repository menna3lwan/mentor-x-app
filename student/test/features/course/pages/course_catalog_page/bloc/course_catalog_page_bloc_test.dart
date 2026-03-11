import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_course_repository/mock_course_repository.dart';

import 'package:mentorx_student/features/course/pages/course_catalog_page/bloc/course_catalog_page_bloc.dart';

void main() {
  late MockCourseRepository courseRepository;

  setUp(() {
    courseRepository = const MockCourseRepository(delay: Duration.zero);
  });

  group('CourseCatalogPageBloc', () {
    blocTest<CourseCatalogPageBloc, CourseCatalogPageState>(
      'loads categories and courses when initialized',
      build: () => CourseCatalogPageBloc(courseRepository: courseRepository),
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
      build: () => CourseCatalogPageBloc(courseRepository: courseRepository),
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
      build: () => CourseCatalogPageBloc(courseRepository: courseRepository),
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
      build: () => CourseCatalogPageBloc(courseRepository: courseRepository),
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
  });
}
