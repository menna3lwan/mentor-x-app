import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'settings_list_event.dart';
part 'settings_list_state.dart';

sealed class SettingsListPresentationEvent {
  const SettingsListPresentationEvent();
}

final class SettingsListNavigateBack
    extends SettingsListPresentationEvent {
  const SettingsListNavigateBack();
}

final class SettingsListBloc
    extends Bloc<SettingsListEvent, SettingsListState>
    with
        BlocPresentationMixin<
          SettingsListState,
          SettingsListPresentationEvent
        > {
  SettingsListBloc({
    required this.settingsRepository,
    required AnalyticsService analyticsService,
  }) : _analyticsService = analyticsService,
       super(SettingsListState.initial) {
    on<SettingsListLoadEvent>(_onLoad);
  }

  final SettingsRepository settingsRepository;
  final AnalyticsService _analyticsService;

  Future<void> _onLoad(
    SettingsListLoadEvent event,
    Emitter<SettingsListState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
    _analyticsService.logEvent(name: AnalyticsEvents.settingsViewed);
  }
}
