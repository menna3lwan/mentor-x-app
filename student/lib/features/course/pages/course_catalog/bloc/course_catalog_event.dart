part of 'course_catalog_bloc.dart';

sealed class CourseCatalogEvent extends Equatable {
  const CourseCatalogEvent();

  @override
  List<Object?> get props => [];
}

final class CourseCatalogInitialized extends CourseCatalogEvent {
  const CourseCatalogInitialized();
}

final class CourseCatalogSearchChanged extends CourseCatalogEvent {
  final String query;

  const CourseCatalogSearchChanged(this.query);

  @override
  List<Object?> get props => [query];
}

final class CourseCatalogCategoryChanged extends CourseCatalogEvent {
  final String? categoryId;

  const CourseCatalogCategoryChanged(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

final class CourseCatalogGradeChanged extends CourseCatalogEvent {
  final String? gradeId;

  const CourseCatalogGradeChanged(this.gradeId);

  @override
  List<Object?> get props => [gradeId];
}

final class CourseCatalogSortChanged extends CourseCatalogEvent {
  final CatalogSortOption sortOption;

  const CourseCatalogSortChanged(this.sortOption);

  @override
  List<Object?> get props => [sortOption];
}

final class CourseCatalogRefreshed extends CourseCatalogEvent {
  const CourseCatalogRefreshed();
}
