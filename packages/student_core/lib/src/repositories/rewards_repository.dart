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
  Future<void> initialize();

  /// Fetch points transaction history.
  Future<List<PointsTransactionEntity>> getPointsHistory({
    MentorXPaginationInfo? paginationInfo,
  });

  /// Fetch available reward items.
  Future<List<RewardItemEntity>> getRewardItems({
    MentorXPaginationInfo? paginationInfo,
  });

  /// Fetch the student's reward claims.
  Future<List<RewardClaimEntity>> getRewardClaims({
    MentorXPaginationInfo? paginationInfo,
  });

  /// Claim a reward item.
  Future<RewardClaimEntity> claimReward(String rewardItemId);
}
