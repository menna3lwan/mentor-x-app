part of 'analytics_bloc.dart';

sealed class AnalyticsEvent extends Equatable {
  const AnalyticsEvent();

  @override
  List<Object?> get props => const [];
}

final class AnalyticsStarted extends AnalyticsEvent {
  final String childId;
  const AnalyticsStarted(this.childId);

  @override
  List<Object?> get props => [childId];
}

final class AnalyticsRefreshRequested extends AnalyticsEvent {
  final String childId;
  const AnalyticsRefreshRequested(this.childId);

  @override
  List<Object?> get props => [childId];
}

final class AnalyticsRetrySectionRequested extends AnalyticsEvent {
  final AnalyticsSection section;
  const AnalyticsRetrySectionRequested(this.section);

  @override
  List<Object?> get props => [section];
}
