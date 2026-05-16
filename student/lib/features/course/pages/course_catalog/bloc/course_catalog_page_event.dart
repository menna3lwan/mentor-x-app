part of 'course_catalog_page_bloc.dart';

sealed class CourseCatalogPageEvent extends Equatable {
  const CourseCatalogPageEvent();

  @override
  List<Object?> get props => [];
}

final class CourseCatalogPageInitialized extends CourseCatalogPageEvent {
  const CourseCatalogPageInitialized();
}

final class CourseCatalogPageSearchChanged extends CourseCatalogPageEvent {
  final String query;

  const CourseCatalogPageSearchChanged(this.query);

  @override
  List<Object?> get props => [query];
}

final class CourseCatalogPageCategoryChanged extends CourseCatalogPageEvent {
  final String? categoryId;

  const CourseCatalogPageCategoryChanged(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

final class CourseCatalogPageGradeChanged extends CourseCatalogPageEvent {
  final String? gradeId;

  const CourseCatalogPageGradeChanged(this.gradeId);

  @override
  List<Object?> get props => [gradeId];
}

final class CourseCatalogPageSortChanged extends CourseCatalogPageEvent {
  final CatalogSortOption sortOption;

  const CourseCatalogPageSortChanged(this.sortOption);

  @override
  List<Object?> get props => [sortOption];
}

final class CourseCatalogPageRefreshed extends CourseCatalogPageEvent {
  const CourseCatalogPageRefreshed();
}
