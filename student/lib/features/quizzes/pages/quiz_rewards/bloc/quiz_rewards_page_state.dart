part of 'quiz_rewards_page_bloc.dart';

final class QuizRewardsPageState extends Equatable {
  final LoadingState loadingState;
  final List<LeaderboardEntryEntity> leaderboardEntries;

  const QuizRewardsPageState({
    this.loadingState = LoadingState.initial,
    this.leaderboardEntries = const [],
  });

  static const initial = QuizRewardsPageState();

  @override
  List<Object?> get props => [loadingState, leaderboardEntries];

  QuizRewardsPageState copyWith({
    LoadingState? loadingState,
    List<LeaderboardEntryEntity>? leaderboardEntries,
  }) {
    return QuizRewardsPageState(
      loadingState: loadingState ?? this.loadingState,
      leaderboardEntries: leaderboardEntries ?? this.leaderboardEntries,
    );
  }
}
