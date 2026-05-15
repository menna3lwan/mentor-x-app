part of 'courses_bloc.dart';

enum CoursesSectionStatus { initial, loading, loaded, failure }

enum CoursesSection { courses, summary, trend }

final class CoursesAsyncSection<T> extends Equatable {
  final CoursesSectionStatus status;
  final T? data;
  final String? errorMessage;

  const CoursesAsyncSection._({
    required this.status,
    this.data,
    this.errorMessage,
  });

  const CoursesAsyncSection.initial()
      : this._(status: CoursesSectionStatus.initial);
  const CoursesAsyncSection.loading({T? data})
      : this._(status: CoursesSectionStatus.loading, data: data);
  const CoursesAsyncSection.loaded(T data)
      : this._(status: CoursesSectionStatus.loaded, data: data);
  const CoursesAsyncSection.failure(String message, {T? data})
      : this._(
          status: CoursesSectionStatus.failure,
          data: data,
          errorMessage: message,
        );

  bool get isInitial => status == CoursesSectionStatus.initial;
  bool get isLoading => status == CoursesSectionStatus.loading;
  bool get isLoaded => status == CoursesSectionStatus.loaded;
  bool get isFailure => status == CoursesSectionStatus.failure;

  CoursesAsyncSection<T> toLoading() =>
      CoursesAsyncSection.loading(data: data);

  @override
  List<Object?> get props => [status, data, errorMessage];
}

final class CoursesState extends Equatable {
  final String? childId;
  final bool isRefreshing;

  final CoursesAsyncSection<List<CourseEntity>> coursesSection;
  final CoursesAsyncSection<ParentGradeSummaryEntity> summarySection;
  final CoursesAsyncSection<ParentGradeTrendEntity> trendSection;

  const CoursesState({
    required this.childId,
    required this.isRefreshing,
    required this.coursesSection,
    required this.summarySection,
    required this.trendSection,
  });

  factory CoursesState.initial() {
    return const CoursesState(
      childId: null,
      isRefreshing: false,
      coursesSection: CoursesAsyncSection.initial(),
      summarySection: CoursesAsyncSection.initial(),
      trendSection: CoursesAsyncSection.initial(),
    );
  }

  List<CourseEntity> get courses =>
      coursesSection.data ?? const <CourseEntity>[];

  ParentGradeSummaryEntity? get gradeSummary => summarySection.data;
  ParentGradeTrendEntity? get gradeTrend => trendSection.data;

  CoursesState copyWith({
    String? childId,
    bool? isRefreshing,
    CoursesAsyncSection<List<CourseEntity>>? coursesSection,
    CoursesAsyncSection<ParentGradeSummaryEntity>? summarySection,
    CoursesAsyncSection<ParentGradeTrendEntity>? trendSection,
  }) {
    return CoursesState(
      childId: childId ?? this.childId,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      coursesSection: coursesSection ?? this.coursesSection,
      summarySection: summarySection ?? this.summarySection,
      trendSection: trendSection ?? this.trendSection,
    );
  }

  @override
  List<Object?> get props => [
        childId,
        isRefreshing,
        coursesSection,
        summarySection,
        trendSection,
      ];
}
