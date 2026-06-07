import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'ai_chat_event.dart';
part 'ai_chat_state.dart';

sealed class AiChatPresentationEvent {
  const AiChatPresentationEvent();
}

final class AiChatNavigateBack extends AiChatPresentationEvent {
  const AiChatNavigateBack();
}

final class AiChatBloc extends Bloc<AiChatEvent, AiChatState>
    with BlocPresentationMixin<AiChatState, AiChatPresentationEvent> {
  static final MentorXLogger _logger = MentorXLogger('AiChatBloc');

  AiChatBloc({
    required this.aiRepository,
    required this.analyticsService,
  }) : super(AiChatState.initial) {
    on<AiChatLoadEvent>(_onLoad);
    on<AiChatSendMessage>(_onSendMessage);
  }

  final AIRepository aiRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    AiChatLoadEvent event,
    Emitter<AiChatState> emit,
  ) async {
    _logger.info('_onLoad entered');
    emit(
      state.copyWith(loadingState: LoadingState.loading, errorMessage: null),
    );
    try {
      // Create or get last conversation. For now, let's create a new one for each session
      // if we want to keep it simple, or we could fetch the last one.
      final conversation = await aiRepository.createConversation();
      final messages = await aiRepository.getMessages(conversation.id);

      _logger.info('_onLoad success: conversationId: ${conversation.id}, messages: ${messages.length}');
      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          conversationId: conversation.id,
          messages: messages,
        ),
      );
    } catch (e, s) {
      _logger.error('_onLoad error', e, s);
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onSendMessage(
    AiChatSendMessage event,
    Emitter<AiChatState> emit,
  ) async {
    _logger.info('_onSendMessage entered: content length: ${event.content.length}');
    if (state.conversationId == null) {
      _logger.warning('_onSendMessage failed: conversationId is null');
      return;
    }

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

      _logger.info('_onSendMessage success');
      emit(
        state.copyWith(
          messages: [...state.messages, responseMessage],
          isTyping: false,
        ),
      );
      analyticsService.logEvent(
        name: AnalyticsEvents.aiMessageSent,
        parameters: {
          AnalyticsParams.conversationId: state.conversationId,
        },
      );
    } catch (e, s) {
      _logger.error('_onSendMessage error', e, s);
      emit(
        state.copyWith(
          isTyping: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
