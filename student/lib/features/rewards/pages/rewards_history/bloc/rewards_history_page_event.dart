part of 'rewards_history_page_bloc.dart';

sealed class RewardsHistoryPageEvent {
  const RewardsHistoryPageEvent();
}

final class RewardsHistoryPageStartedEvent extends RewardsHistoryPageEvent {
  const RewardsHistoryPageStartedEvent();
}

final class RewardsHistoryPageRefreshedEvent extends RewardsHistoryPageEvent {
  const RewardsHistoryPageRefreshedEvent();
}

final class RewardsHistoryPageRetryEvent extends RewardsHistoryPageEvent {
  const RewardsHistoryPageRetryEvent();
}
