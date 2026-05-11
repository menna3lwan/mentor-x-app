part of 'analytics_dashboard_page_bloc.dart';

sealed class AnalyticsDashboardPageEvent extends Equatable {
  const AnalyticsDashboardPageEvent();

  @override
  List<Object?> get props => [];
}

final class AnalyticsDashboardPageLoadRequested
    extends AnalyticsDashboardPageEvent {
  const AnalyticsDashboardPageLoadRequested();
}

final class AnalyticsDashboardPageRefreshed
    extends AnalyticsDashboardPageEvent {
  const AnalyticsDashboardPageRefreshed();
}

final class AnalyticsDashboardPageCourseChanged
    extends AnalyticsDashboardPageEvent {
  final String? courseId;
  const AnalyticsDashboardPageCourseChanged(this.courseId);

  @override
  List<Object?> get props => [courseId];
}
