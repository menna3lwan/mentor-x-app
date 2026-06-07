import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'shell_event.dart';
part 'shell_state.dart';

sealed class ShellPresentationEvent {
  const ShellPresentationEvent();
}

final class ShellNavigateBack extends ShellPresentationEvent {
  const ShellNavigateBack();
}

final class ShellBloc extends Bloc<ShellEvent, ShellState>
    with BlocPresentationMixin<ShellState, ShellPresentationEvent> {
  static final MentorXLogger _logger = MentorXLogger('ShellBloc');

  final AnalyticsService _analyticsService;

  ShellBloc({
    required AnalyticsService analyticsService,
  }) : _analyticsService = analyticsService,
       super(ShellState.initial) {
    _analyticsService.logEvent(name: 'shell_viewed');
    on<ShellLoadEvent>(_onLoad);
  }

  Future<void> _onLoad(
    ShellLoadEvent event,
    Emitter<ShellState> emit,
  ) async {
    _logger.info('_onLoad entered');
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
