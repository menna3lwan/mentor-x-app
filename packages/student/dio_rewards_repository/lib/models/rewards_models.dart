import 'package:mentorx_core/mentorx_core.dart';

abstract final class PointsTransactionModel {
  static PointsTransactionEntity fromJson(Map<String, dynamic> json) {
    return PointsTransactionEntity(
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

abstract final class RewardItemModel {
  static RewardItemEntity fromJson(Map<String, dynamic> json) {
    return RewardItemEntity(
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

abstract final class RewardClaimModel {
  static RewardClaimEntity fromJson(Map<String, dynamic> json) {
    return RewardClaimEntity(
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
