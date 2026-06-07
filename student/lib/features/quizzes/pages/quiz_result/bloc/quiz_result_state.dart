part of 'quiz_result_bloc.dart';

final class QuizResultState extends Equatable {
  final LoadingState loadingState;
  final QuizAttemptEntity? result;
  final LeaderboardEntryEntity? myRank;
  final List<LeaderboardEntryEntity> leaderboard;
  final String? errorMessage;

  const QuizResultState({
    this.loadingState = LoadingState.initial,
    this.result,
    this.myRank,
    this.leaderboard = const [],
    this.errorMessage,
  });

  static const initial = QuizResultState();

  @override
  List<Object?> get props => [
    loadingState,
    result,
    myRank,
    leaderboard,
    errorMessage,
  ];

  QuizResultState copyWith({
    LoadingState? loadingState,
    QuizAttemptEntity? result,
    LeaderboardEntryEntity? myRank,
    List<LeaderboardEntryEntity>? leaderboard,
    String? errorMessage,
  }) {
    return QuizResultState(
      loadingState: loadingState ?? this.loadingState,
      result: result ?? this.result,
      myRank: myRank ?? this.myRank,
      leaderboard: leaderboard ?? this.leaderboard,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
