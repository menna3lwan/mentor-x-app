part of '../../student_core.dart';

enum RewardClaimStatus { pending, approved, rejected, delivered }

base class RewardClaimEntity extends Equatable {
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


  static final placeholder = RewardClaimEntity(
    id: '',
    rewardItemId: '',
    pointsSpent: 0,
    status: RewardClaimStatus.pending,
    claimedAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

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
