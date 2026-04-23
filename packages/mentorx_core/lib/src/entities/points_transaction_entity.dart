part of 'package:mentorx_core/mentorx_core.dart';

enum PointsTransactionType { earned, redeemed, expired, deducted }


class PointsTransactionEntity extends Equatable {
  final String id;
  final int amount;
  final int balanceAfter;
  final String description;
  final DateTime createdAt;
  final String? typeBadge; // "Quiz" / "Course" / "Reward" / "Promo"

  const PointsTransactionEntity({
    required this.id,
    required this.amount,
    required this.balanceAfter,
    required this.description,
    required this.createdAt,
    this.typeBadge,
  });

  bool get isCredit => amount > 0;

  static final placeholder = PointsTransactionEntity(
    id: '',
    amount: 0,
    balanceAfter: 0,
    description: '',
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

  @override
  List<Object?> get props => [
        id,
        amount,
        balanceAfter,
        description,
        createdAt,
        typeBadge,
      ];

  PointsTransactionEntity copyWith({
    String? id,
    int? amount,
    int? balanceAfter,
    String? description,
    DateTime? createdAt,
    String? typeBadge,
  }) {
    return PointsTransactionEntity(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      balanceAfter: balanceAfter ?? this.balanceAfter,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      typeBadge: typeBadge ?? this.typeBadge,
    );
  }
}
