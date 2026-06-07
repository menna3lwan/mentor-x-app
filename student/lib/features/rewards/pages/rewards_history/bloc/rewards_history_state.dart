part of 'rewards_history_bloc.dart';

final class RewardsHistoryState extends Equatable {
  final AsyncSection<List<PointsTransactionEntity>> historySection;

  const RewardsHistoryState({
    this.historySection = const AsyncSection.initial(),
  });

  @override
  List<Object?> get props => [historySection];

  RewardsHistoryState copyWith({
    AsyncSection<List<PointsTransactionEntity>>? historySection,
  }) {
    return RewardsHistoryState(
      historySection: historySection ?? this.historySection,
    );
  }
}
