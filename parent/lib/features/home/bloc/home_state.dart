part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

final class HomeState extends Equatable {
  final HomeStatus status;
  final List<ParentChildEntity> children;
  final ParentChildEntity? selectedChild;
  final ParentHomeSummaryEntity? summary;
  final List<ParentRecentActivityEntity> recentActivity;
  final List<AnnouncementEntity> announcements;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.children = const [],
    this.selectedChild,
    this.summary,
    this.recentActivity = const [],
    this.announcements = const [],
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<ParentChildEntity>? children,
    ParentChildEntity? selectedChild,
    ParentHomeSummaryEntity? summary,
    List<ParentRecentActivityEntity>? recentActivity,
    List<AnnouncementEntity>? announcements,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      children: children ?? this.children,
      selectedChild: selectedChild ?? this.selectedChild,
      summary: summary ?? this.summary,
      recentActivity: recentActivity ?? this.recentActivity,
      announcements: announcements ?? this.announcements,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        children,
        selectedChild,
        summary,
        recentActivity,
        announcements,
        errorMessage,
      ];
}
