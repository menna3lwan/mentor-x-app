part of 'leaderboard_page_bloc.dart';

final class LeaderboardPageState extends Equatable {
  final LoadingState loadingState;
  final List<LeaderboardEntryEntity> leaderboard;
  final LeaderboardEntryEntity? myRank;
  final List<CourseSummaryEntity> courses;
  final String? selectedCourseId;
  final String? errorMessage;

  const LeaderboardPageState({
    this.loadingState = LoadingState.initial,
    this.leaderboard = const [],
    this.myRank,
    this.courses = const [],
    this.selectedCourseId,
    this.errorMessage,
  });

  LeaderboardPageState copyWith({
    LoadingState? loadingState,
    List<LeaderboardEntryEntity>? leaderboard,
    LeaderboardEntryEntity? myRank,
    List<CourseSummaryEntity>? courses,
    String? selectedCourseId,
    String? errorMessage,
  }) {
    return LeaderboardPageState(
      loadingState: loadingState ?? this.loadingState,
      leaderboard: leaderboard ?? this.leaderboard,
      myRank: myRank ?? this.myRank,
      courses: courses ?? this.courses,
      selectedCourseId: selectedCourseId ?? this.selectedCourseId,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    loadingState,
    leaderboard,
    myRank,
    courses,
    selectedCourseId,
    errorMessage,
  ];
}
