part of 'quiz_rewards_page_bloc.dart';

final class QuizRewardsPageState extends Equatable {
  final LoadingState loadingState;

  const QuizRewardsPageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = QuizRewardsPageState();

  @override
  List<Object?> get props => [loadingState];

  QuizRewardsPageState copyWith({LoadingState? loadingState}) {
    return QuizRewardsPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
