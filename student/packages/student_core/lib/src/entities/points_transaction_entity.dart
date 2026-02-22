part of '../../student_core.dart';

enum PointsTransactionType { earn, spend }

final class PointsTransactionEntity extends Equatable {
  final String id;
  final PointsTransactionType transactionType;
  final int points;
  final int balanceAfter;
  final String source;
  final DateTime createdAt;

  const PointsTransactionEntity({
    required this.id,
    required this.transactionType,
    required this.points,
    required this.balanceAfter,
    required this.source,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        transactionType,
        points,
        balanceAfter,
        source,
        createdAt,
      ];
}
