part of 'analytics_dashboard_bloc.dart';

sealed class AnalyticsDashboardEvent extends Equatable {
  const AnalyticsDashboardEvent();

  @override
  List<Object?> get props => [];
}

final class AnalyticsDashboardLoadRequested
    extends AnalyticsDashboardEvent {
  const AnalyticsDashboardLoadRequested();
}

final class AnalyticsDashboardRefreshed
    extends AnalyticsDashboardEvent {
  const AnalyticsDashboardRefreshed();
}

final class AnalyticsDashboardCourseChanged
    extends AnalyticsDashboardEvent {
  final String? courseId;
  const AnalyticsDashboardCourseChanged(this.courseId);

  @override
  List<Object?> get props => [courseId];
}
