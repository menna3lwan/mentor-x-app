import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:mentorx_student/core/core.dart';

part 'ai_chat_page_event.dart';
part 'ai_chat_page_state.dart';

sealed class AiChatPagePresentationEvent {
  const AiChatPagePresentationEvent();
}

final class AiChatPageNavigateBack extends AiChatPagePresentationEvent {
  const AiChatPageNavigateBack();
}

final class AiChatPageBloc extends Bloc<AiChatPageEvent, AiChatPageState>
    with BlocPresentationMixin<AiChatPageState, AiChatPagePresentationEvent> {
  AiChatPageBloc({required this.aiRepository})
    : super(AiChatPageState.initial) {
    on<AiChatPageLoadEvent>(_onLoad);
  }

  final AIRepository aiRepository;

  Future<void> _onLoad(
    AiChatPageLoadEvent event,
    Emitter<AiChatPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
