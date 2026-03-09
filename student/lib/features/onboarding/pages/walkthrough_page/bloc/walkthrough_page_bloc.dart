import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'walkthrough_page_event.dart';
part 'walkthrough_page_state.dart';

final class WalkthroughPageBloc
    extends Bloc<WalkthroughPageEvent, WalkthroughPageState> {
  final CacheRepository _cacheRepository;

  WalkthroughPageBloc({
    required CacheRepository cacheRepository,
  }) : _cacheRepository = cacheRepository,
       super(const WalkthroughPageState()) {
    on<WalkthroughPageSkipped>(_persistAndComplete);
    on<WalkthroughPageCompleted>(_persistAndComplete);
  }

  Future<void> _persistAndComplete(
    WalkthroughPageEvent event,
    Emitter<WalkthroughPageState> emit,
  ) async {
    emit(state.copyWith(status: WalkthroughPageStatus.submitting));

    try {
      await _cacheRepository.put('has_seen_onboarding', 'true');
      emit(state.copyWith(status: WalkthroughPageStatus.completed));
    } catch (_) {
      emit(state.copyWith(status: WalkthroughPageStatus.failure));
    }
  }
}
