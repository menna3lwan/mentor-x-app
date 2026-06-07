import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';

part 'rewards_history_event.dart';
part 'rewards_history_state.dart';

final class RewardsHistoryBloc
    extends Bloc<RewardsHistoryEvent, RewardsHistoryState> {
  static final MentorXLogger _logger = MentorXLogger('RewardsHistoryBloc');
  final RewardsRepository _rewardsRepository;
  final AnalyticsService _analyticsService;

  RewardsHistoryBloc({
    required RewardsRepository rewardsRepository,
    required AnalyticsService analyticsService,
  }) : _rewardsRepository = rewardsRepository,
       _analyticsService = analyticsService,
       super(const RewardsHistoryState()) {
    on<RewardsHistoryStartedEvent>(_onStarted);
    on<RewardsHistoryRefreshedEvent>(_onRefreshed);
    on<RewardsHistoryRetryEvent>(_onRetry);
  }

  Future<void> _onStarted(
    RewardsHistoryStartedEvent event,
    Emitter<RewardsHistoryState> emit,
  ) async {
    _logger.info('Handling RewardsHistoryStartedEvent');
    _analyticsService.logEvent(name: AnalyticsEvents.rewardsHistoryViewed);
    await _loadHistory(emit);
  }

  Future<void> _onRefreshed(
    RewardsHistoryRefreshedEvent event,
    Emitter<RewardsHistoryState> emit,
  ) async {
    _logger.info('Handling RewardsHistoryRefreshedEvent');
    await _loadHistory(emit);
  }

  Future<void> _onRetry(
    RewardsHistoryRetryEvent event,
    Emitter<RewardsHistoryState> emit,
  ) async {
    _logger.info('Handling RewardsHistoryRetryEvent');
    await _loadHistory(emit);
  }

  Future<void> _loadHistory(Emitter<RewardsHistoryState> emit) async {
    _logger.debug('Loading rewards history data');
    emit(state.copyWith(historySection: const AsyncSection.loading()));

    try {
      final history = await _rewardsRepository.getPointsHistory();
      emit(state.copyWith(historySection: AsyncSection.success(history)));
      _logger.info('Rewards history loaded successfully');
    } catch (e, s) {
      _logger.error('Failed to load rewards history data', e, s);
      emit(state.copyWith(historySection: const AsyncSection.failure()));
    }
  }
}
