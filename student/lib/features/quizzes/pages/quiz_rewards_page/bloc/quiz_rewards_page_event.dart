part of 'quiz_rewards_page_bloc.dart';

sealed class QuizRewardsPageEvent extends Equatable {
  const QuizRewardsPageEvent();

  @override
  List<Object?> get props => [];
}

final class QuizRewardsPageLoadEvent extends QuizRewardsPageEvent {
  const QuizRewardsPageLoadEvent();
}
