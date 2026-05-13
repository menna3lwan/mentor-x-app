part of 'my_courses_page_bloc.dart';

enum MyCoursesTab { inProgress, completed, expired }

final class MyCoursesPageState extends Equatable {
  final LoadingState loadingState;
  final MyCoursesTab selectedTab;
  final List<EnrollmentEntity> courses;
  final String searchQuery;
  final String? errorMessage;

  const MyCoursesPageState({
    required this.loadingState,
    this.selectedTab = MyCoursesTab.inProgress,
    this.courses = const [],
    this.searchQuery = '',
    this.errorMessage,
  });

  static const initial = MyCoursesPageState(loadingState: LoadingState.initial);

  bool get isLoading => loadingState.isLoading;
  bool get isLoaded => loadingState.isLoaded;

  MyCoursesPageState copyWith({
    LoadingState? loadingState,
    MyCoursesTab? selectedTab,
    List<EnrollmentEntity>? courses,
    String? searchQuery,
    String? errorMessage,
  }) {
    return MyCoursesPageState(
      loadingState: loadingState ?? this.loadingState,
      selectedTab: selectedTab ?? this.selectedTab,
      courses: courses ?? this.courses,
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    loadingState,
    selectedTab,
    courses,
    searchQuery,
    errorMessage,
  ];
}
