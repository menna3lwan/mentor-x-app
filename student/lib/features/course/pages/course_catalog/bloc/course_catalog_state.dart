part of 'course_catalog_bloc.dart';

enum CatalogSectionStatus { initial, loading, loaded, failure }

enum CatalogSortOption { newest, priceAsc, priceDesc, popular }

final class CourseCatalogState extends Equatable {
  final CatalogSectionStatus coursesStatus;
  final CatalogSectionStatus categoriesStatus;
  final CatalogSectionStatus gradesStatus;
  final List<CourseSummaryEntity> courses;
  final List<CategoryEntity> categories;
  final List<GradeEntity> grades;
  final String searchQuery;
  final String? selectedGradeId;
  final String? selectedCategoryId;
  final CatalogSortOption sortOption;
  final String? errorMessage;

  const CourseCatalogState({
    this.coursesStatus = CatalogSectionStatus.initial,
    this.categoriesStatus = CatalogSectionStatus.initial,
    this.gradesStatus = CatalogSectionStatus.initial,
    this.courses = const [],
    this.categories = const [],
    this.grades = const [],
    this.searchQuery = '',
    this.selectedGradeId,
    this.selectedCategoryId,
    this.sortOption = CatalogSortOption.newest,
    this.errorMessage,
  });

  bool get isCoursesLoading => coursesStatus == CatalogSectionStatus.loading;
  bool get isCoursesLoaded => coursesStatus == CatalogSectionStatus.loaded;
  bool get isCoursesFailure => coursesStatus == CatalogSectionStatus.failure;

  CourseCatalogState copyWith({
    CatalogSectionStatus? coursesStatus,
    CatalogSectionStatus? categoriesStatus,
    CatalogSectionStatus? gradesStatus,
    List<CourseSummaryEntity>? courses,
    List<CategoryEntity>? categories,
    List<GradeEntity>? grades,
    String? searchQuery,
    String? selectedGradeId,
    String? selectedCategoryId,
    bool clearGrade = false,
    bool clearCategory = false,
    CatalogSortOption? sortOption,
    String? errorMessage,
  }) {
    return CourseCatalogState(
      coursesStatus: coursesStatus ?? this.coursesStatus,
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
      gradesStatus: gradesStatus ?? this.gradesStatus,
      courses: courses ?? this.courses,
      categories: categories ?? this.categories,
      grades: grades ?? this.grades,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedGradeId: clearGrade
          ? null
          : (selectedGradeId ?? this.selectedGradeId),
      selectedCategoryId: clearCategory
          ? null
          : (selectedCategoryId ?? this.selectedCategoryId),
      sortOption: sortOption ?? this.sortOption,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    coursesStatus,
    categoriesStatus,
    gradesStatus,
    courses,
    categories,
    grades,
    searchQuery,
    selectedGradeId,
    selectedCategoryId,
    sortOption,
    errorMessage,
  ];
}
