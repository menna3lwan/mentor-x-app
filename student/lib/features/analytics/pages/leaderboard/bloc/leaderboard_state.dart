part of 'leaderboard_bloc.dart';

final class LeaderboardState extends Equatable {
  final LoadingState loadingState;
  final List<LeaderboardEntryEntity> leaderboard;
  final LeaderboardEntryEntity? myRank;
  final List<EnrollmentEntity> courses;
  final String? selectedCourseId;
  final String? errorMessage;

  const LeaderboardState({
    this.loadingState = LoadingState.initial,
    this.leaderboard = const [],
    this.myRank,
    this.courses = const [],
    this.selectedCourseId,
    this.errorMessage,
  });

  LeaderboardState copyWith({
    LoadingState? loadingState,
    List<LeaderboardEntryEntity>? leaderboard,
    LeaderboardEntryEntity? myRank,
    List<EnrollmentEntity>? courses,
    String? selectedCourseId,
    String? errorMessage,
  }) {
    return LeaderboardState(
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
