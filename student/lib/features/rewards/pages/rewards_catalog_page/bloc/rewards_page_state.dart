part of 'rewards_page_bloc.dart';

class RewardsPageState extends Equatable {
  final AsyncSection<int> pointsSection;
  final AsyncSection<List<RewardItemEntity>> itemsSection;
  final AsyncSection<List<PointsTransactionEntity>> historySection;
  final bool isClaiming;

  const RewardsPageState({
    this.pointsSection = const AsyncSection.initial(),
    this.itemsSection = const AsyncSection.initial(),
    this.historySection = const AsyncSection.initial(),
    this.isClaiming = false,
  });

  RewardsPageState copyWith({
    AsyncSection<int>? pointsSection,
    AsyncSection<List<RewardItemEntity>>? itemsSection,
    AsyncSection<List<PointsTransactionEntity>>? historySection,
    bool? isClaiming,
  }) {
    return RewardsPageState(
      pointsSection: pointsSection ?? this.pointsSection,
      itemsSection: itemsSection ?? this.itemsSection,
      historySection: historySection ?? this.historySection,
      isClaiming: isClaiming ?? this.isClaiming,
    );
  }

  bool get isFirstLoading =>
      pointsSection.isInitial &&
      itemsSection.isInitial &&
      historySection.isInitial;

  @override
  List<Object?> get props => [
    pointsSection,
    itemsSection,
    historySection,
    isClaiming,
  ];
}
