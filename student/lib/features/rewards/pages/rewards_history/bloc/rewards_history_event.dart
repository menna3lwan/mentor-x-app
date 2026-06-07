part of 'rewards_history_bloc.dart';

sealed class RewardsHistoryEvent {
  const RewardsHistoryEvent();
}

final class RewardsHistoryStartedEvent extends RewardsHistoryEvent {
  const RewardsHistoryStartedEvent();
}

final class RewardsHistoryRefreshedEvent extends RewardsHistoryEvent {
  const RewardsHistoryRefreshedEvent();
}

final class RewardsHistoryRetryEvent extends RewardsHistoryEvent {
  const RewardsHistoryRetryEvent();
}
