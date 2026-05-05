part of 'home_page_bloc.dart';

enum HomeSectionStatus { initial, loading, loaded, failure }

enum HomeSection {
  wallet,
  unreadCount,
  banners,
  continueLearning,
  featuredCourses,
  announcements,
}

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

  HomeAsyncSection<T> toLoading() => HomeAsyncSection.loading(data: data);

  @override
  List<Object?> get props => [status, data, errorMessage];
}

final class HomePageState extends Equatable {
  final String studentName;
  final bool isRefreshing;
  final DateTime? lastUpdatedAt;

  final HomeAsyncSection<WalletSummaryEntity> walletSection;
  final HomeAsyncSection<int> unreadCountSection;
  final HomeAsyncSection<List<BannerEntity>> bannersSection;
  final HomeAsyncSection<List<CourseSummaryEntity>> continueLearningSection;
  final HomeAsyncSection<List<CourseSummaryEntity>> featuredCoursesSection;
  final HomeAsyncSection<List<AnnouncementEntity>> announcementsSection;

  const HomePageState({
    required this.studentName,
    required this.isRefreshing,
    required this.walletSection,
    required this.unreadCountSection,
    required this.bannersSection,
    required this.continueLearningSection,
    required this.featuredCoursesSection,
    required this.announcementsSection,
    this.lastUpdatedAt,
  });

  factory HomePageState.initial({required String studentName}) {
    return HomePageState(
      studentName: studentName,
      isRefreshing: false,
      walletSection: const HomeAsyncSection.initial(),
      unreadCountSection: const HomeAsyncSection.initial(),
      bannersSection: const HomeAsyncSection.initial(),
      continueLearningSection: const HomeAsyncSection.initial(),
      featuredCoursesSection: const HomeAsyncSection.initial(),
      announcementsSection: const HomeAsyncSection.initial(),
    );
  }

  bool get isFirstLoading =>
      walletSection.isInitial &&
      unreadCountSection.isInitial &&
      bannersSection.isInitial &&
      continueLearningSection.isInitial &&
      featuredCoursesSection.isInitial &&
      announcementsSection.isInitial;

  HomePageState copyWith({
    String? studentName,
    bool? isRefreshing,
    DateTime? lastUpdatedAt,
    HomeAsyncSection<WalletSummaryEntity>? walletSection,
    HomeAsyncSection<int>? unreadCountSection,
    HomeAsyncSection<List<BannerEntity>>? bannersSection,
    HomeAsyncSection<List<CourseSummaryEntity>>? continueLearningSection,
    HomeAsyncSection<List<CourseSummaryEntity>>? featuredCoursesSection,
    HomeAsyncSection<List<AnnouncementEntity>>? announcementsSection,
  }) {
    return HomePageState(
      studentName: studentName ?? this.studentName,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      walletSection: walletSection ?? this.walletSection,
      unreadCountSection: unreadCountSection ?? this.unreadCountSection,
      bannersSection: bannersSection ?? this.bannersSection,
      continueLearningSection:
          continueLearningSection ?? this.continueLearningSection,
      featuredCoursesSection:
          featuredCoursesSection ?? this.featuredCoursesSection,
      announcementsSection: announcementsSection ?? this.announcementsSection,
    );
  }

  @override
  List<Object?> get props => [
    studentName,
    isRefreshing,
    lastUpdatedAt,
    walletSection,
    unreadCountSection,
    bannersSection,
    continueLearningSection,
    featuredCoursesSection,
    announcementsSection,
  ];
}
