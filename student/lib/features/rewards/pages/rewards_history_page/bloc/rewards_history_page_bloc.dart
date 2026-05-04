import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

part 'rewards_history_page_event.dart';
part 'rewards_history_page_state.dart';

final class RewardsHistoryPageBloc
    extends Bloc<RewardsHistoryPageEvent, RewardsHistoryPageState> {
  final RewardsRepository _rewardsRepository;

  RewardsHistoryPageBloc({
    required RewardsRepository rewardsRepository,
  }) : _rewardsRepository = rewardsRepository,
       super(const RewardsHistoryPageState()) {
    on<RewardsHistoryPageStartedEvent>(_onStarted);
    on<RewardsHistoryPageRefreshedEvent>(_onRefreshed);
    on<RewardsHistoryPageRetryEvent>(_onRetry);
  }

  Future<void> _onStarted(
    RewardsHistoryPageStartedEvent event,
    Emitter<RewardsHistoryPageState> emit,
  ) async {
    await _loadHistory(emit);
  }

  Future<void> _onRefreshed(
    RewardsHistoryPageRefreshedEvent event,
    Emitter<RewardsHistoryPageState> emit,
  ) async {
    await _loadHistory(emit);
  }

  Future<void> _onRetry(
    RewardsHistoryPageRetryEvent event,
    Emitter<RewardsHistoryPageState> emit,
  ) async {
    await _loadHistory(emit);
  }

  Future<void> _loadHistory(Emitter<RewardsHistoryPageState> emit) async {
    emit(state.copyWith(historySection: const AsyncSection.loading()));

    try {
      final history = await _rewardsRepository.getPointsHistory();
      emit(state.copyWith(historySection: AsyncSection.success(history)));
    } catch (e) {
      emit(state.copyWith(historySection: const AsyncSection.failure()));
    }
  }
}
