import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:mentorx_student/core/core.dart';

part 'support_page_event.dart';
part 'support_page_state.dart';

sealed class SupportPagePresentationEvent {
  const SupportPagePresentationEvent();
}

final class SupportPageNavigateBack extends SupportPagePresentationEvent {
  const SupportPageNavigateBack();
}

final class SupportPageBloc extends Bloc<SupportPageEvent, SupportPageState>
    with BlocPresentationMixin<SupportPageState, SupportPagePresentationEvent> {
  SupportPageBloc() : super(SupportPageState.initial) {
    on<SupportPageLoadEvent>(_onLoad);
  }

  Future<void> _onLoad(
    SupportPageLoadEvent event,
    Emitter<SupportPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
