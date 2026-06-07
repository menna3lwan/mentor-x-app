part of 'analytics_dashboard_bloc.dart';

enum AnalyticsDashboardStatus { initial, loading, success, failure }

final class AnalyticsDashboardState extends Equatable {
  final AnalyticsDashboardStatus status;
  final List<EnrollmentEntity> courses;
  final String? selectedCourseId;
  final StudentAnalyticsSummaryEntity? summary;
  final String? errorMessage;

  const AnalyticsDashboardState({
    this.status = AnalyticsDashboardStatus.initial,
    this.courses = const [],
    this.selectedCourseId,
    this.summary,
    this.errorMessage,
  });

  AnalyticsDashboardState copyWith({
    AnalyticsDashboardStatus? status,
    List<EnrollmentEntity>? courses,
    String? selectedCourseId,
    StudentAnalyticsSummaryEntity? summary,
    String? errorMessage,
    bool clearSelectedCourse = false,
  }) {
    return AnalyticsDashboardState(
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
