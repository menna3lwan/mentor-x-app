part of '../../student_core.dart';

enum RewardClaimStatus { pending, approved, rejected, delivered }

final class RewardClaimEntity extends Equatable {
  final String id;
  final String rewardItemId;
  final String? rewardTitle;
  final int pointsSpent;
  final RewardClaimStatus status;
  final DateTime claimedAt;

  const RewardClaimEntity({
    required this.id,
    required this.rewardItemId,
    required this.pointsSpent,
    required this.status,
    required this.claimedAt,
    this.rewardTitle,
  });

  @override
  List<Object?> get props => [
        id,
        rewardItemId,
        rewardTitle,
        pointsSpent,
        status,
        claimedAt,
      ];
}
