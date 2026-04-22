part of '../../mock_data.dart';

final class MockRewardsGenerator {
  MockRewardsGenerator._();

  static List<PointsTransactionEntity> pointsHistory() {
    final now = DateTime.now();
    return [
      PointsTransactionEntity(
        id: 'pt1',
        description: 'Quiz completed: Algebra Ch.3',
        amount: 50,
        balanceAfter: 450,
        typeBadge: 'Quiz',
        createdAt: now.subtract(const Duration(hours: 3)),
      ),
      PointsTransactionEntity(
        id: 'pt2',
        description: 'Assignment submitted: History Essay',
        amount: 100,
        balanceAfter: 400,
        typeBadge: 'Assignment',
        createdAt: now.subtract(const Duration(days: 1)),
      ),
      PointsTransactionEntity(
        id: 'pt3',
        description: 'Redeemed: Stationery Kit',
        amount: 200,
        balanceAfter: 300,
        typeBadge: 'Reward',
        createdAt: now.subtract(const Duration(days: 3)),
      ),
      PointsTransactionEntity(
        id: 'pt4',
        description: 'Login bonus',
        amount: 30,
        balanceAfter: 500,
        typeBadge: 'Promo',
        createdAt: now.subtract(const Duration(days: 5)),
      ),
    ];
  }

  static List<RewardItemEntity> rewardItems() {
    final now = DateTime.now();
    return [
      RewardItemEntity(
        id: 'ri1',
        title: 'Stationery Kit',
        imageUrl: 'https://picsum.photos/200/200?reward=1',
        requiredPoints: 200,
        remainingQuantity: 15,
        perUserLimit: 1,
        isActive: true,
        isFeatured: true,
        availableUntil: now.add(const Duration(days: 30)),
      ),
      RewardItemEntity(
        id: 'ri2',
        title: 'Water Bottle',
        imageUrl: 'https://picsum.photos/200/200?reward=2',
        requiredPoints: 150,
        remainingQuantity: 30,
        perUserLimit: 1,
        isActive: true,
        isFeatured: false,
      ),
      RewardItemEntity(
        id: 'ri3',
        title: 'MentorX T-Shirt',
        imageUrl: 'https://picsum.photos/200/200?reward=3',
        requiredPoints: 500,
        remainingQuantity: 5,
        perUserLimit: 1,
        isActive: true,
        isFeatured: true,
      ),
    ];
  }

  static List<RewardClaimEntity> rewardClaims() {
    final now = DateTime.now();
    return [
      RewardClaimEntity(
        id: 'rc1',
        rewardItemId: 'ri1',
        rewardTitle: 'Stationery Kit',
        pointsSpent: 200,
        status: RewardClaimStatus.delivered,
        claimedAt: now.subtract(const Duration(days: 10)),
      ),
    ];
  }

  static RewardClaimEntity claimReward({
    required String rewardItemId,
    required int pointsSpent,
    String? rewardTitle,
  }) {
    return RewardClaimEntity(
      id: 'rc_new_${DateTime.now().millisecondsSinceEpoch}',
      rewardItemId: rewardItemId,
      rewardTitle: rewardTitle,
      pointsSpent: pointsSpent,
      status: RewardClaimStatus.pending,
      claimedAt: DateTime.now(),
    );
  }
}
