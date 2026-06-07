import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'rewards_catalog_event.dart';
part 'rewards_catalog_state.dart';

sealed class RewardsCatalogPresentationEvent {}

class RewardsCatalogClaimSuccessPresentationEvent extends RewardsCatalogPresentationEvent {
  final String rewardTitle;
  RewardsCatalogClaimSuccessPresentationEvent(this.rewardTitle);
}

class RewardsCatalogFailurePresentationEvent extends RewardsCatalogPresentationEvent {
  final String message;
  RewardsCatalogFailurePresentationEvent(this.message);
}

class RewardsCatalogBloc extends Bloc<RewardsCatalogEvent, RewardsCatalogState>
    with BlocPresentationMixin<RewardsCatalogState, RewardsCatalogPresentationEvent> {
  final RewardsRepository _rewardsRepository;
  final WalletRepository _walletRepository;
  final AnalyticsService _analyticsService;

  RewardsCatalogBloc({
    required RewardsRepository rewardsRepository,
    required WalletRepository walletRepository,
    required AnalyticsService analyticsService,
  }) : _rewardsRepository = rewardsRepository,
       _walletRepository = walletRepository,
       _analyticsService = analyticsService,
       super(const RewardsCatalogState()) {
    on<RewardsPageStartedEvent>(_onStarted);
    on<RewardsPageRefreshedEvent>(_onRefreshed);
    on<RewardsPageClaimRequestedEvent>(_onClaimRequested);
    on<RewardsPageRetryEvent>(_onRetry);
  }

  Future<void> _onStarted(
    RewardsPageStartedEvent event,
    Emitter<RewardsCatalogState> emit,
  ) async {
    await _loadAll(emit);
  }

  Future<void> _onRefreshed(
    RewardsPageRefreshedEvent event,
    Emitter<RewardsCatalogState> emit,
  ) async {
    await _loadAll(emit);
  }

  Future<void> _onRetry(
    RewardsPageRetryEvent event,
    Emitter<RewardsCatalogState> emit,
  ) async {
    await _loadAll(emit);
  }

  Future<void> _loadAll(Emitter<RewardsCatalogState> emit) async {
    emit(
      state.copyWith(
        pointsSection: const AsyncSection.loading(),
        itemsSection: const AsyncSection.loading(),
        historySection: const AsyncSection.loading(),
      ),
    );

    try {
      final results = await Future.wait([
        _walletRepository.getSummary(),
        _rewardsRepository.getRewardItems(),
        _rewardsRepository.getPointsHistory(),
      ]);

      final wallet = results[0] as WalletSummaryEntity;
      final items = results[1] as List<RewardItemEntity>;
      final history = results[2] as List<PointsTransactionEntity>;

      emit(
        state.copyWith(
          pointsSection: AsyncSection.success(wallet.points),
          itemsSection: AsyncSection.success(items),
          historySection: AsyncSection.success(history),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          pointsSection: const AsyncSection.failure(),
          itemsSection: const AsyncSection.failure(),
          historySection: const AsyncSection.failure(),
        ),
      );
      emitPresentation(RewardsCatalogFailurePresentationEvent(e.toString()));
    }
  }

  Future<void> _onClaimRequested(
    RewardsPageClaimRequestedEvent event,
    Emitter<RewardsCatalogState> emit,
  ) async {
    if (state.isClaiming) return;

    emit(state.copyWith(isClaiming: true));
    try {
      final claim = await _rewardsRepository.claimReward(event.rewardItemId);
      emitPresentation(
        RewardsCatalogClaimSuccessPresentationEvent(claim.rewardTitle ?? 'Reward'),
      );
      _analyticsService.logEvent(
        name: AnalyticsEvents.rewardClaimed,
        parameters: {
          AnalyticsParams.itemId: event.rewardItemId,
          AnalyticsParams.itemName: claim.rewardTitle,
        },
      );
      // Reload points after claim
      final wallet = await _walletRepository.getSummary();
      emit(
        state.copyWith(
          pointsSection: AsyncSection.success(wallet.points),
          isClaiming: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isClaiming: false));
      emitPresentation(RewardsCatalogFailurePresentationEvent(e.toString()));
    }
  }
}
