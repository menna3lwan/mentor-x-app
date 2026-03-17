import 'package:student_core/student_core.dart';

final class PointsTransactionModel extends PointsTransactionEntity {
  const PointsTransactionModel({
    required super.id,
    required super.transactionType,
    required super.points,
    required super.balanceAfter,
    required super.source,
    required super.createdAt,
  });

  factory PointsTransactionModel.fromJson(Map<String, dynamic> json) {
    return PointsTransactionModel(
      id: json['id']?.toString() ?? '',
      transactionType: _parseType(json['transactionType'] ?? json['transaction_type']),
      points: (json['points'] as num?)?.toInt() ?? 0,
      balanceAfter: (json['balanceAfter'] ?? json['balance_after'] as num?)?.toInt() ?? 0,
      source: json['source'] as String? ?? '',
      createdAt: DateTime.parse((json['createdAt'] ?? json['created_at']) as String),
    );
  }

  static PointsTransactionType _parseType(dynamic value) {
    final str = value?.toString().toLowerCase();
    return PointsTransactionType.values.firstWhere(
      (e) => e.name == str,
      orElse: () => PointsTransactionType.earn,
    );
  }
}

final class RewardItemModel extends RewardItemEntity {
  const RewardItemModel({
    required super.id,
    required super.title,
    required super.requiredPoints,
    super.imageUrl,
    super.remainingQuantity,
    super.perUserLimit,
    super.isActive,
    super.isFeatured,
    super.availableFrom,
    super.availableUntil,
  });

  factory RewardItemModel.fromJson(Map<String, dynamic> json) {
    return RewardItemModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] as String? ?? '',
      imageUrl: (json['imageUrl'] ?? json['image_url']) as String?,
      requiredPoints: (json['requiredPoints'] ?? json['required_points'] as num?)?.toInt() ?? 0,
      remainingQuantity: (json['remainingQuantity'] ?? json['remaining_quantity'] as num?)?.toInt(),
      perUserLimit: (json['perUserLimit'] ?? json['per_user_limit'] as num?)?.toInt() ?? 1,
      isActive: json['isActive'] as bool? ?? json['is_active'] as bool? ?? true,
      isFeatured: json['isFeatured'] as bool? ?? json['is_featured'] as bool? ?? false,
      availableFrom: (json['availableFrom'] ?? json['available_from']) != null 
          ? DateTime.tryParse((json['availableFrom'] ?? json['available_from']) as String) 
          : null,
      availableUntil: (json['availableUntil'] ?? json['available_until']) != null 
          ? DateTime.tryParse((json['availableUntil'] ?? json['available_until']) as String) 
          : null,
    );
  }
}

final class RewardClaimModel extends RewardClaimEntity {
  const RewardClaimModel({
    required super.id,
    required super.rewardItemId,
    required super.pointsSpent,
    required super.status,
    required super.claimedAt,
    super.rewardTitle,
  });

  factory RewardClaimModel.fromJson(Map<String, dynamic> json) {
    return RewardClaimModel(
      id: json['id']?.toString() ?? '',
      rewardItemId: (json['rewardItemId'] ?? json['reward_item_id'])?.toString() ?? '',
      rewardTitle: (json['rewardTitle'] ?? json['reward_title'] ?? json['reward']?['title']) as String?,
      pointsSpent: (json['pointsSpent'] ?? json['points_spent'] as num?)?.toInt() ?? 0,
      status: _parseStatus(json['status']),
      claimedAt: DateTime.parse((json['claimedAt'] ?? json['claimed_at']) as String),
    );
  }

  static RewardClaimStatus _parseStatus(dynamic value) {
    final str = value?.toString().toLowerCase();
    return RewardClaimStatus.values.firstWhere(
      (e) => e.name == str,
      orElse: () => RewardClaimStatus.pending,
    );
  }
}
