import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'rewards_page_event.dart';
part 'rewards_page_state.dart';

sealed class RewardsPagePresentationEvent {}

class RewardsPageClaimSuccessPresentationEvent
    extends RewardsPagePresentationEvent {
  final String rewardTitle;
  RewardsPageClaimSuccessPresentationEvent(this.rewardTitle);
}

class RewardsPageFailurePresentationEvent extends RewardsPagePresentationEvent {
  final String message;
  RewardsPageFailurePresentationEvent(this.message);
}

class RewardsPageBloc extends Bloc<RewardsPageEvent, RewardsPageState>
    with BlocPresentationMixin<RewardsPageState, RewardsPagePresentationEvent> {
  final RewardsRepository _rewardsRepository;
  final WalletRepository _walletRepository;

  RewardsPageBloc({
    required RewardsRepository rewardsRepository,
    required WalletRepository walletRepository,
  }) : _rewardsRepository = rewardsRepository,
       _walletRepository = walletRepository,
       super(const RewardsPageState()) {
    on<RewardsPageStartedEvent>(_onStarted);
    on<RewardsPageRefreshedEvent>(_onRefreshed);
    on<RewardsPageClaimRequestedEvent>(_onClaimRequested);
    on<RewardsPageRetryEvent>(_onRetry);
  }

  Future<void> _onStarted(
    RewardsPageStartedEvent event,
    Emitter<RewardsPageState> emit,
  ) async {
    await _loadAll(emit);
  }

  Future<void> _onRefreshed(
    RewardsPageRefreshedEvent event,
    Emitter<RewardsPageState> emit,
  ) async {
    await _loadAll(emit);
  }

  Future<void> _onRetry(
    RewardsPageRetryEvent event,
    Emitter<RewardsPageState> emit,
  ) async {
    await _loadAll(emit);
  }

  Future<void> _loadAll(Emitter<RewardsPageState> emit) async {
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
      emitPresentation(RewardsPageFailurePresentationEvent(e.toString()));
    }
  }

  Future<void> _onClaimRequested(
    RewardsPageClaimRequestedEvent event,
    Emitter<RewardsPageState> emit,
  ) async {
    if (state.isClaiming) return;

    emit(state.copyWith(isClaiming: true));
    try {
      final claim = await _rewardsRepository.claimReward(event.rewardItemId);
      emitPresentation(
        RewardsPageClaimSuccessPresentationEvent(claim.rewardTitle ?? 'Reward'),
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
      emitPresentation(RewardsPageFailurePresentationEvent(e.toString()));
    }
  }
}
