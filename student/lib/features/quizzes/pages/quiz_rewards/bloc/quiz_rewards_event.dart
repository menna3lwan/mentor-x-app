part of 'quiz_rewards_bloc.dart';

sealed class QuizRewardsEvent extends Equatable {
  const QuizRewardsEvent();

  @override
  List<Object?> get props => [];
}

final class QuizRewardsLoadEvent extends QuizRewardsEvent {
  const QuizRewardsLoadEvent();
}
