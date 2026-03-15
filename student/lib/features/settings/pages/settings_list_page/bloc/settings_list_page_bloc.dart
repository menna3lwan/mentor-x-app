import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:mentorx_student/core/core.dart';

part 'settings_list_page_event.dart';
part 'settings_list_page_state.dart';

sealed class SettingsListPagePresentationEvent {
  const SettingsListPagePresentationEvent();
}

final class SettingsListPageNavigateBack
    extends SettingsListPagePresentationEvent {
  const SettingsListPageNavigateBack();
}

final class SettingsListPageBloc
    extends Bloc<SettingsListPageEvent, SettingsListPageState>
    with
        BlocPresentationMixin<
          SettingsListPageState,
          SettingsListPagePresentationEvent
        > {
  SettingsListPageBloc({required this.settingsRepository})
    : super(SettingsListPageState.initial) {
    on<SettingsListPageLoadEvent>(_onLoad);
  }

  final SettingsRepository settingsRepository;

  Future<void> _onLoad(
    SettingsListPageLoadEvent event,
    Emitter<SettingsListPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
