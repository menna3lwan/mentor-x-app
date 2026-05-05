import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
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
    on<AiChatPageSendMessage>(_onSendMessage);
  }

  final AIRepository aiRepository;

  Future<void> _onLoad(
    AiChatPageLoadEvent event,
    Emitter<AiChatPageState> emit,
  ) async {
    emit(
      state.copyWith(loadingState: LoadingState.loading, errorMessage: null),
    );
    try {
      // Create or get last conversation. For now, let's create a new one for each session
      // if we want to keep it simple, or we could fetch the last one.
      final conversation = await aiRepository.createConversation();
      final messages = await aiRepository.getMessages(conversation.id);

      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          conversationId: conversation.id,
          messages: messages,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onSendMessage(
    AiChatPageSendMessage event,
    Emitter<AiChatPageState> emit,
  ) async {
    if (state.conversationId == null) return;

    final userMessage = AIMessageEntity(
      id: DateTime.now().toIso8601String(),
      conversationId: state.conversationId!,
      content: event.content,
      role: AIMessageRole.user,
      createdAt: DateTime.now(),
    );

    emit(
      state.copyWith(
        messages: [...state.messages, userMessage],
        isTyping: true,
      ),
    );

    try {
      final responseMessage = await aiRepository.sendMessage(
        state.conversationId!,
        event.content,
      );

      emit(
        state.copyWith(
          messages: [...state.messages, responseMessage],
          isTyping: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isTyping: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
