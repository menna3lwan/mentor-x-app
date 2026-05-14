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
      id: ModelParser.asString(json['id']),
      amount: ModelParser.asInt(json['amount'] ?? json['points'] ?? json['value']),
      balanceAfter: ModelParser.asInt(json['balanceAfter'] ?? json['balance_after'] ?? json['current_points'] ?? json['totalPoints']),
      description: ModelParser.asString(json['description'] ?? json['reason'] ?? json['title']),
      createdAt: ModelParser.asDateTime(json['createdAt'] ?? json['created_at'] ?? json['date']) ?? DateTime.now(),
      typeBadge: ModelParser.asString(json['typeBadge'] ?? json['type_badge'] ?? json['type']),
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
      id: ModelParser.asString(json['id']),
      title: ModelParser.asString(json['title'] ?? json['name']),
      requiredPoints: ModelParser.asInt(json['required_points'] ?? json['points_cost'] ?? json['requiredPoints'] ?? json['points']),
      imageUrl: ModelParser.asString(json['image_url'] ?? json['imageUrl'] ?? json['image']),
      isActive: ModelParser.asBool(json['is_active'] ?? json['isActive'] ?? json['enabled'], fallback: true),
      remainingQuantity: ModelParser.asInt(json['remaining_quantity'] ?? json['stock_quantity'] ?? json['remainingQuantity'] ?? json['stock']),
      perUserLimit: ModelParser.asInt(json['per_user_limit'] ?? json['perUserLimit'] ?? json['limit'], fallback: 1),
      isFeatured: ModelParser.asBool(json['is_featured'] ?? json['isFeatured'] ?? json['featured']),
      availableFrom: ModelParser.asDateTime(json['available_from'] ?? json['availableFrom'] ?? json['start_date']),
      availableUntil: ModelParser.asDateTime(json['available_until'] ?? json['availableUntil'] ?? json['end_date']),
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
      id: ModelParser.asString(json['id']),
      rewardItemId: ModelParser.asString(json['reward_item_id'] ?? json['rewardItemId'] ?? json['itemId']),
      rewardTitle: ModelParser.asString(json['reward_title'] ?? json['rewardTitle'] ?? json['itemName']),
      pointsSpent: ModelParser.asInt(json['points_spent'] ?? json['pointsCost'] ?? json['pointsSpent'] ?? json['points']),
      status: _parseStatus(json['status']),
      claimedAt: ModelParser.asDateTime(json['claimed_at'] ?? json['claimedAt'] ?? json['createdAt']) ?? DateTime.now(),
    );
  }

  static RewardClaimStatus _parseStatus(dynamic value) {
    final str = ModelParser.asString(value).toLowerCase();
    return RewardClaimStatus.values.firstWhere(
      (e) => e.name == str,
      orElse: () => RewardClaimStatus.pending,
    );
  }
}
