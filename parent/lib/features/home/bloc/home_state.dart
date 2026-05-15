part of 'home_bloc.dart';

enum HomeSectionStatus { initial, loading, loaded, failure }

enum HomeSection { children, summary, activity, announcements }

/// Generic, immutable container for a single dashboard section's async state.
/// Mirrors `HomeAsyncSection` in the student app so both apps share the
/// same loading pattern.
final class HomeAsyncSection<T> extends Equatable {
  final HomeSectionStatus status;
  final T? data;
  final String? errorMessage;

  const HomeAsyncSection._({
    required this.status,
    this.data,
    this.errorMessage,
  });

  const HomeAsyncSection.initial() : this._(status: HomeSectionStatus.initial);

  const HomeAsyncSection.loading({T? data})
      : this._(status: HomeSectionStatus.loading, data: data);

  const HomeAsyncSection.loaded(T data)
      : this._(status: HomeSectionStatus.loaded, data: data);

  const HomeAsyncSection.failure(String message, {T? data})
      : this._(
          status: HomeSectionStatus.failure,
          data: data,
          errorMessage: message,
        );

  bool get isInitial => status == HomeSectionStatus.initial;
  bool get isLoading => status == HomeSectionStatus.loading;
  bool get isLoaded => status == HomeSectionStatus.loaded;
  bool get isFailure => status == HomeSectionStatus.failure;

  /// Convenience: transitions to loading while preserving any previous data
  /// (so the UI can show stale content with a refresh indicator).
  HomeAsyncSection<T> toLoading() => HomeAsyncSection.loading(data: data);

  @override
  List<Object?> get props => [status, data, errorMessage];
}

final class HomeState extends Equatable {
  final ParentChildEntity? selectedChild;
  final bool isRefreshing;
  final DateTime? lastUpdatedAt;

  final HomeAsyncSection<List<ParentChildEntity>> childrenSection;
  final HomeAsyncSection<ParentHomeSummaryEntity> summarySection;
  final HomeAsyncSection<List<ParentRecentActivityEntity>> activitySection;
  final HomeAsyncSection<List<AnnouncementEntity>> announcementsSection;

  const HomeState({
    required this.selectedChild,
    required this.isRefreshing,
    required this.lastUpdatedAt,
    required this.childrenSection,
    required this.summarySection,
    required this.activitySection,
    required this.announcementsSection,
  });

  factory HomeState.initial() {
    return const HomeState(
      selectedChild: null,
      isRefreshing: false,
      lastUpdatedAt: null,
      childrenSection: HomeAsyncSection.initial(),
      summarySection: HomeAsyncSection.initial(),
      activitySection: HomeAsyncSection.initial(),
      announcementsSection: HomeAsyncSection.initial(),
    );
  }

  // ─── Derived getters ──────────────────────────────────────────────────
  List<ParentChildEntity> get children =>
      childrenSection.data ?? const <ParentChildEntity>[];

  bool get hasChildren => children.isNotEmpty;

  bool get isFirstLoading =>
      childrenSection.isInitial || childrenSection.isLoading;

  /// `true` if every section is still in its initial/loading state with no
  /// data. Used to show the first-paint skeleton instead of a partial layout.
  bool get isInitialPaint =>
      (childrenSection.isInitial || childrenSection.isLoading) &&
      summarySection.data == null &&
      activitySection.data == null &&
      announcementsSection.data == null;

  HomeState copyWith({
    ParentChildEntity? selectedChild,
    bool? isRefreshing,
    DateTime? lastUpdatedAt,
    HomeAsyncSection<List<ParentChildEntity>>? childrenSection,
    HomeAsyncSection<ParentHomeSummaryEntity>? summarySection,
    HomeAsyncSection<List<ParentRecentActivityEntity>>? activitySection,
    HomeAsyncSection<List<AnnouncementEntity>>? announcementsSection,
  }) {
    return HomeState(
      selectedChild: selectedChild ?? this.selectedChild,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      childrenSection: childrenSection ?? this.childrenSection,
      summarySection: summarySection ?? this.summarySection,
      activitySection: activitySection ?? this.activitySection,
      announcementsSection: announcementsSection ?? this.announcementsSection,
    );
  }

  @override
  List<Object?> get props => [
        selectedChild,
        isRefreshing,
        lastUpdatedAt,
        childrenSection,
        summarySection,
        activitySection,
        announcementsSection,
      ];
}
