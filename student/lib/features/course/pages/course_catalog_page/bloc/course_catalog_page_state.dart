part of 'course_catalog_page_bloc.dart';

enum CatalogSectionStatus { initial, loading, loaded, failure }

enum CatalogSortOption { newest, priceAsc, priceDesc, popular }

final class CourseCatalogPageState extends Equatable {
  final CatalogSectionStatus coursesStatus;
  final CatalogSectionStatus categoriesStatus;
  final List<CourseSummaryEntity> courses;
  final List<CategoryEntity> categories;
  final String searchQuery;
  final String? selectedCategoryId;
  final CatalogSortOption sortOption;
  final String? errorMessage;

  const CourseCatalogPageState({
    this.coursesStatus = CatalogSectionStatus.initial,
    this.categoriesStatus = CatalogSectionStatus.initial,
    this.courses = const [],
    this.categories = const [],
    this.searchQuery = '',
    this.selectedCategoryId,
    this.sortOption = CatalogSortOption.newest,
    this.errorMessage,
  });

  bool get isCoursesLoading => coursesStatus == CatalogSectionStatus.loading;
  bool get isCoursesLoaded => coursesStatus == CatalogSectionStatus.loaded;
  bool get isCoursesFailure => coursesStatus == CatalogSectionStatus.failure;

  CourseCatalogPageState copyWith({
    CatalogSectionStatus? coursesStatus,
    CatalogSectionStatus? categoriesStatus,
    List<CourseSummaryEntity>? courses,
    List<CategoryEntity>? categories,
    String? searchQuery,
    String? selectedCategoryId,
    bool clearCategory = false,
    CatalogSortOption? sortOption,
    String? errorMessage,
  }) {
    return CourseCatalogPageState(
      coursesStatus: coursesStatus ?? this.coursesStatus,
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
      courses: courses ?? this.courses,
      categories: categories ?? this.categories,
      searchQuery: searchQuery ?? this.searchQuery,
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
    courses,
    categories,
    searchQuery,
    selectedCategoryId,
    sortOption,
    errorMessage,
  ];
}
