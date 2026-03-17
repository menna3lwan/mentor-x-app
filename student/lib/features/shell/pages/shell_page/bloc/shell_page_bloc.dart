import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'shell_page_event.dart';
part 'shell_page_state.dart';

sealed class ShellPagePresentationEvent {
  const ShellPagePresentationEvent();
}

final class ShellPageNavigateBack extends ShellPagePresentationEvent {
  const ShellPageNavigateBack();
}

final class ShellPageBloc extends Bloc<ShellPageEvent, ShellPageState>
    with BlocPresentationMixin<ShellPageState, ShellPagePresentationEvent> {
  ShellPageBloc() : super(ShellPageState.initial) {
    on<ShellPageLoadEvent>(_onLoad);
  }

  Future<void> _onLoad(
    ShellPageLoadEvent event,
    Emitter<ShellPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
