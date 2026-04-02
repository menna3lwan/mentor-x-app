part of '../../mentorx_core.dart';

enum PointsTransactionType { earn, spend }

base class PointsTransactionEntity extends Equatable {
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


  static final placeholder = PointsTransactionEntity(
    id: '',
    transactionType: PointsTransactionType.earn,
    points: 0,
    balanceAfter: 0,
    source: '',
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

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
