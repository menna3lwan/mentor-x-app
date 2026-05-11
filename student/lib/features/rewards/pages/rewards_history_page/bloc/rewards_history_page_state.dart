part of 'rewards_history_page_bloc.dart';

final class RewardsHistoryPageState extends Equatable {
  final AsyncSection<List<PointsTransactionEntity>> historySection;

  const RewardsHistoryPageState({
    this.historySection = const AsyncSection.initial(),
  });

  @override
  List<Object?> get props => [historySection];

  RewardsHistoryPageState copyWith({
    AsyncSection<List<PointsTransactionEntity>>? historySection,
  }) {
    return RewardsHistoryPageState(
      historySection: historySection ?? this.historySection,
    );
  }
}
