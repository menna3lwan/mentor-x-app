import 'dart:async';

import 'package:mentorx_core/mentorx_core.dart';
import 'package:mock_data/mock_data.dart';

final class MockRewardsRepository implements RewardsRepository {
  final Duration delay;

  const MockRewardsRepository({required this.delay});

  @override
  Future<void> initialize() async {}

  @override
  Future<List<PointsTransactionEntity>> getPointsHistory({
    MentorXPaginationInfo? paginationInfo,
  }) async {
    await Future<void>.delayed(delay);
    return MockRewardsGenerator.pointsHistory();
  }

  @override
  Future<List<RewardItemEntity>> getRewardItems({
    MentorXPaginationInfo? paginationInfo,
  }) async {
    await Future<void>.delayed(delay);
    return MockRewardsGenerator.rewardItems();
  }

  @override
  Future<List<RewardClaimEntity>> getRewardClaims({
    MentorXPaginationInfo? paginationInfo,
  }) async {
    await Future<void>.delayed(delay);
    return MockRewardsGenerator.rewardClaims();
  }

  @override
  Future<RewardClaimEntity> claimReward(String rewardItemId) async {
    await Future<void>.delayed(delay);
    final items = MockRewardsGenerator.rewardItems();
    final item = items.firstWhere(
      (e) => e.id == rewardItemId,
      orElse: () => items.first,
    );
    return MockRewardsGenerator.claimReward(
      rewardItemId: rewardItemId,
      pointsSpent: item.requiredPoints,
      rewardTitle: item.title,
    );
  }
}
