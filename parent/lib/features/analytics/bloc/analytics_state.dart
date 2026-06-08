part of 'analytics_bloc.dart';

enum AnalyticsSectionStatus { initial, loading, loaded, failure }

enum AnalyticsSection {
  gradeComparison,
  courseProgress,
  activeHours,
  achievements,
  streak,
  quizSpeed,
}

/// Generic async section wrapper. Mirrors the pattern used by [HomeBloc] so
/// the UI can be skeletoned / retried per-tile.
final class AnalyticsAsyncSection<T> extends Equatable {
  final AnalyticsSectionStatus status;
  final T? data;
  final String? errorMessage;

  const AnalyticsAsyncSection._({
    required this.status,
    this.data,
    this.errorMessage,
  });

  const AnalyticsAsyncSection.initial()
    : this._(status: AnalyticsSectionStatus.initial);

  const AnalyticsAsyncSection.loading([T? data])
    : this._(status: AnalyticsSectionStatus.loading, data: data);

  const AnalyticsAsyncSection.loaded(T data)
    : this._(status: AnalyticsSectionStatus.loaded, data: data);

  const AnalyticsAsyncSection.failure(String message)
    : this._(
        status: AnalyticsSectionStatus.failure,
        errorMessage: message,
      );

  bool get isInitial => status == AnalyticsSectionStatus.initial;
  bool get isLoading => status == AnalyticsSectionStatus.loading;
  bool get isLoaded => status == AnalyticsSectionStatus.loaded;
  bool get isFailure => status == AnalyticsSectionStatus.failure;

  AnalyticsAsyncSection<T> toLoading() => AnalyticsAsyncSection.loading(data);

  @override
  List<Object?> get props => [status, data, errorMessage];
}

final class AnalyticsState extends Equatable {
  final String? childId;
  final bool isRefreshing;
  final AnalyticsAsyncSection<ParentChildGradeComparisonEntity> gradeComparison;
  final AnalyticsAsyncSection<ParentChildCourseProgressEntity> courseProgress;
  final AnalyticsAsyncSection<ParentChildActiveHoursEntity> activeHours;
  final AnalyticsAsyncSection<ParentChildAchievementsEntity> achievements;
  final AnalyticsAsyncSection<StreakEntity> streak;
  final AnalyticsAsyncSection<ParentChildQuizSpeedEntity> quizSpeed;

  const AnalyticsState({
    required this.gradeComparison,
    required this.courseProgress,
    required this.activeHours,
    required this.achievements,
    required this.streak,
    required this.quizSpeed,
    this.childId,
    this.isRefreshing = false,
  });

  factory AnalyticsState.initial() => const AnalyticsState(
    gradeComparison: AnalyticsAsyncSection.initial(),
    courseProgress: AnalyticsAsyncSection.initial(),
    activeHours: AnalyticsAsyncSection.initial(),
    achievements: AnalyticsAsyncSection.initial(),
    streak: AnalyticsAsyncSection.initial(),
    quizSpeed: AnalyticsAsyncSection.initial(),
  );

  AnalyticsState copyWith({
    String? childId,
    bool? isRefreshing,
    AnalyticsAsyncSection<ParentChildGradeComparisonEntity>? gradeComparison,
    AnalyticsAsyncSection<ParentChildCourseProgressEntity>? courseProgress,
    AnalyticsAsyncSection<ParentChildActiveHoursEntity>? activeHours,
    AnalyticsAsyncSection<ParentChildAchievementsEntity>? achievements,
    AnalyticsAsyncSection<StreakEntity>? streak,
    AnalyticsAsyncSection<ParentChildQuizSpeedEntity>? quizSpeed,
  }) {
    return AnalyticsState(
      childId: childId ?? this.childId,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      gradeComparison: gradeComparison ?? this.gradeComparison,
      courseProgress: courseProgress ?? this.courseProgress,
      activeHours: activeHours ?? this.activeHours,
      achievements: achievements ?? this.achievements,
      streak: streak ?? this.streak,
      quizSpeed: quizSpeed ?? this.quizSpeed,
    );
  }

  @override
  List<Object?> get props => [
    childId,
    isRefreshing,
    gradeComparison,
    courseProgress,
    activeHours,
    achievements,
    streak,
    quizSpeed,
  ];
}
