part of 'rewards_catalog_bloc.dart';

abstract class RewardsCatalogEvent extends Equatable {
  const RewardsCatalogEvent();

  @override
  List<Object?> get props => [];
}

class RewardsPageStartedEvent extends RewardsCatalogEvent {
  const RewardsPageStartedEvent();
}

class RewardsPageRefreshedEvent extends RewardsCatalogEvent {
  const RewardsPageRefreshedEvent();
}

class RewardsPageClaimRequestedEvent extends RewardsCatalogEvent {
  final String rewardItemId;

  const RewardsPageClaimRequestedEvent(this.rewardItemId);

  @override
  List<Object?> get props => [rewardItemId];
}

class RewardsPageRetryEvent extends RewardsCatalogEvent {
  const RewardsPageRetryEvent();
}
