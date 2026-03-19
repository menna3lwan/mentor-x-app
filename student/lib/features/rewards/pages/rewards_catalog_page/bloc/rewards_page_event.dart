part of 'rewards_page_bloc.dart';

abstract class RewardsPageEvent extends Equatable {
  const RewardsPageEvent();

  @override
  List<Object?> get props => [];
}

class RewardsPageStartedEvent extends RewardsPageEvent {
  const RewardsPageStartedEvent();
}

class RewardsPageRefreshedEvent extends RewardsPageEvent {
  const RewardsPageRefreshedEvent();
}

class RewardsPageClaimRequestedEvent extends RewardsPageEvent {
  final String rewardItemId;

  const RewardsPageClaimRequestedEvent(this.rewardItemId);

  @override
  List<Object?> get props => [rewardItemId];
}

class RewardsPageRetryEvent extends RewardsPageEvent {
  const RewardsPageRetryEvent();
}
