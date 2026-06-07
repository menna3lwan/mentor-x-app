part of 'quiz_rewards_bloc.dart';

final class QuizRewardsState extends Equatable {
  final LoadingState loadingState;
  final List<LeaderboardEntryEntity> leaderboardEntries;

  const QuizRewardsState({
    this.loadingState = LoadingState.initial,
    this.leaderboardEntries = const [],
  });

  static const initial = QuizRewardsState();

  @override
  List<Object?> get props => [loadingState, leaderboardEntries];

  QuizRewardsState copyWith({
    LoadingState? loadingState,
    List<LeaderboardEntryEntity>? leaderboardEntries,
  }) {
    return QuizRewardsState(
      loadingState: loadingState ?? this.loadingState,
      leaderboardEntries: leaderboardEntries ?? this.leaderboardEntries,
    );
  }
}
