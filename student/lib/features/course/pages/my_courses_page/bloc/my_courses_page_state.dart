part of 'my_courses_page_bloc.dart';

enum MyCoursesPageStatus { initial, loading, loaded, failure }

enum MyCoursesTab { inProgress, completed, expired }

final class MyCoursesPageState extends Equatable {
  final MyCoursesPageStatus status;
  final MyCoursesTab selectedTab;
  final List<CourseSummaryEntity> courses;
  final String searchQuery;
  final String? errorMessage;

  const MyCoursesPageState({
    this.status = MyCoursesPageStatus.initial,
    this.selectedTab = MyCoursesTab.inProgress,
    this.courses = const [],
    this.searchQuery = '',
    this.errorMessage,
  });

  bool get isLoading => status == MyCoursesPageStatus.loading;
  bool get isLoaded => status == MyCoursesPageStatus.loaded;
  bool get isFailure => status == MyCoursesPageStatus.failure;
  bool get isInitial => status == MyCoursesPageStatus.initial;

  MyCoursesPageState copyWith({
    MyCoursesPageStatus? status,
    MyCoursesTab? selectedTab,
    List<CourseSummaryEntity>? courses,
    String? searchQuery,
    String? errorMessage,
  }) {
    return MyCoursesPageState(
      status: status ?? this.status,
      selectedTab: selectedTab ?? this.selectedTab,
      courses: courses ?? this.courses,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    selectedTab,
    courses,
    searchQuery,
    errorMessage,
  ];
}
