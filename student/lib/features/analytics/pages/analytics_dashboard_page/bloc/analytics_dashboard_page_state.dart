part of 'analytics_dashboard_page_bloc.dart';

enum AnalyticsDashboardStatus { initial, loading, success, failure }

final class AnalyticsDashboardPageState extends Equatable {
  final AnalyticsDashboardStatus status;
  final List<CourseSummaryEntity> courses;
  final String? selectedCourseId;
  final StudentAnalyticsSummaryEntity? summary;
  final String? errorMessage;

  const AnalyticsDashboardPageState({
    this.status = AnalyticsDashboardStatus.initial,
    this.courses = const [],
    this.selectedCourseId,
    this.summary,
    this.errorMessage,
  });

  AnalyticsDashboardPageState copyWith({
    AnalyticsDashboardStatus? status,
    List<CourseSummaryEntity>? courses,
    String? selectedCourseId,
    StudentAnalyticsSummaryEntity? summary,
    String? errorMessage,
    bool clearSelectedCourse = false,
  }) {
    return AnalyticsDashboardPageState(
      status: status ?? this.status,
      courses: courses ?? this.courses,
      selectedCourseId: clearSelectedCourse
          ? null
          : (selectedCourseId ?? this.selectedCourseId),
      summary: summary ?? this.summary,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    courses,
    selectedCourseId,
    summary,
    errorMessage,
  ];
}
