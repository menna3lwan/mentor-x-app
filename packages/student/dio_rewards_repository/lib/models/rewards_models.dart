import 'package:mentorx_core/mentorx_core.dart';

final class PointsTransactionModel extends PointsTransactionEntity {
  const PointsTransactionModel({
    required super.id,
    required super.amount,
    required super.balanceAfter,
    required super.description,
    required super.createdAt,
    super.typeBadge,
  });

  factory PointsTransactionModel.fromJson(Map<String, dynamic> json) {
    return PointsTransactionModel(
      id: json['id']?.toString() ?? '',
      amount: (json['amount'] ?? 0).toInt(),
      balanceAfter: (json['balanceAfter'] ?? json['balance_after'] ?? 0).toInt(),
      description: (json['description'] ?? json['reason'] ?? '') as String,
      createdAt: DateTime.tryParse(
            (json['createdAt'] ?? json['created_at'])?.toString() ?? '',
          ) ??
          DateTime.now(),
      typeBadge:
          (json['typeBadge'] ?? json['type_badge'] ?? json['type'])?.toString(),
    );
  }
}

final class RewardItemModel extends RewardItemEntity {
  const RewardItemModel({
    required super.id,
    required super.title,
    required super.requiredPoints,
    super.imageUrl,
    super.isActive = true,
    super.remainingQuantity,
    super.perUserLimit = 1,
    super.isFeatured = false,
    super.availableFrom,
    super.availableUntil,
  });

  factory RewardItemModel.fromJson(Map<String, dynamic> json) {
    return RewardItemModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      requiredPoints: (json['required_points'] ?? json['points_cost'] ?? 0).toInt(),
      imageUrl: json['image_url'],
      isActive: json['is_active'] ?? true,
      remainingQuantity: json['remaining_quantity']?.toInt() ?? json['stock_quantity']?.toInt(),
      perUserLimit: (json['per_user_limit'] ?? 1).toInt(),
      isFeatured: json['is_featured'] ?? false,
      availableFrom: json['available_from'] != null ? DateTime.tryParse(json['available_from']) : null,
      availableUntil: json['available_until'] != null ? DateTime.tryParse(json['available_until']) : null,
    );
  }
}

final class RewardClaimModel extends RewardClaimEntity {
  const RewardClaimModel({
    required super.id,
    required super.rewardItemId,
    super.rewardTitle,
    required super.pointsSpent,
    required super.status,
    required super.claimedAt,
  });

  factory RewardClaimModel.fromJson(Map<String, dynamic> json) {
    return RewardClaimModel(
      id: json['id']?.toString() ?? '',
      rewardItemId: json['reward_item_id']?.toString() ?? '',
      rewardTitle: json['reward_title']?.toString(),
      pointsSpent: (json['points_spent'] ?? json['pointsCost'] ?? 0).toInt(),
      status: RewardClaimStatus.values.firstWhere(
        (e) => e.name == (json['status'] ?? 'pending'),
        orElse: () => RewardClaimStatus.pending,
      ),
      claimedAt: DateTime.tryParse(json['claimed_at'] ?? '') ?? DateTime.now(),
    );
  }
}
