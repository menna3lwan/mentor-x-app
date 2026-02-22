part of '../../student_core.dart';

enum RewardsRepositoryExceptionCode {
  unknown,
  failedToLoadPointsHistory,
  failedToLoadRewardItems,
  failedToLoadClaims,
  failedToClaimReward,
}

final class RewardsRepositoryException
    extends MentorXException<RewardsRepositoryExceptionCode> {
  const RewardsRepositoryException({required super.code, super.message});
}

abstract interface class RewardsRepository {
  /// Fetch points transaction history.
  Future<List<PointsTransactionEntity>> getPointsHistory({
    int page = 1,
    int limit = 20,
  });

  /// Fetch available reward items.
  Future<List<RewardItemEntity>> getRewardItems({
    int page = 1,
    int limit = 20,
  });

  /// Fetch the student's reward claims.
  Future<List<RewardClaimEntity>> getRewardClaims({
    int page = 1,
    int limit = 20,
  });

  /// Claim a reward item.
  Future<RewardClaimEntity> claimReward(String rewardItemId);
}
