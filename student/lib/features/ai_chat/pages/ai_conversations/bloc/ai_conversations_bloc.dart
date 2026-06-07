import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';

import 'package:mentorx_student/core/core.dart';

part 'ai_conversations_event.dart';
part 'ai_conversations_state.dart';

sealed class AiConversationsPresentationEvent {
  const AiConversationsPresentationEvent();
}

final class AiConversationsFailurePresentationEvent
    extends AiConversationsPresentationEvent {
  final String message;

  const AiConversationsFailurePresentationEvent({required this.message});
}

final class AiConversationsOpenChatPresentationEvent
    extends AiConversationsPresentationEvent {
  const AiConversationsOpenChatPresentationEvent();
}

final class AiConversationsBloc
    extends Bloc<AiConversationsEvent, AiConversationsState>
    with
        BlocPresentationMixin<
          AiConversationsState,
          AiConversationsPresentationEvent
        > {
  static final MentorXLogger _logger = MentorXLogger('AiConversationsBloc');
  final AIRepository _aiRepository;
  final AnalyticsService _analyticsService;

  AiConversationsBloc({
    required AIRepository aiRepository,
    required AnalyticsService analyticsService,
  }) : _aiRepository = aiRepository,
       _analyticsService = analyticsService,
       super(AiConversationsState.initial) {
    on<AiConversationsInitialized>(_onInitialized);
    on<AiConversationsRefreshed>(_onRefreshed);
    on<AiConversationsConversationTapped>(_onConversationTapped);
    on<AiConversationsCreateConversationRequested>(
      _onCreateConversationRequested,
    );
    on<AiConversationsDeleteConversationRequested>(
      _onDeleteConversationRequested,
    );
    on<AiConversationsRenameConversationSubmitted>(
      _onRenameConversationSubmitted,
    );
  }

  Future<void> _onInitialized(
    AiConversationsInitialized event,
    Emitter<AiConversationsState> emit,
  ) async {
    _logger.info('_onInitialized entered');
    _analyticsService.logEvent(name: AnalyticsEvents.aiConversationsViewed);
    await _loadConversations(emit: emit);
  }

  Future<void> _onRefreshed(
    AiConversationsRefreshed event,
    Emitter<AiConversationsState> emit,
  ) async {
    _logger.info('_onRefreshed entered');
    await _loadConversations(emit: emit);
  }

  Future<void> _onConversationTapped(
    AiConversationsConversationTapped event,
    Emitter<AiConversationsState> emit,
  ) async {
    _logger.info('_onConversationTapped with id: ${event.conversationId}');
    emitPresentation(const AiConversationsOpenChatPresentationEvent());
  }

  Future<void> _onCreateConversationRequested(
    AiConversationsCreateConversationRequested event,
    Emitter<AiConversationsState> emit,
  ) async {
    _logger.info('_onCreateConversationRequested entered');
    emit(
      state.copyWith(loadingState: LoadingState.loading, errorMessage: null),
    );

    try {
      await _aiRepository.createConversation();
      _logger.info('_onCreateConversationRequested success');
      emitPresentation(const AiConversationsOpenChatPresentationEvent());
      await _loadConversations(emit: emit, isSilent: true);
    } on AIRepositoryException catch (e, s) {
      final message = e.message ?? 'Failed to create conversation.';
      _logger.error('_onCreateConversationRequested AIRepositoryException', e, s);
      emit(
        state.copyWith(loadingState: LoadingState.error, errorMessage: message),
      );
      emitPresentation(
        AiConversationsFailurePresentationEvent(message: message),
      );
    } catch (e, s) {
      final message = e.toString();
      _logger.error('_onCreateConversationRequested unknown error', e, s);
      emit(
        state.copyWith(loadingState: LoadingState.error, errorMessage: message),
      );
      emitPresentation(
        AiConversationsFailurePresentationEvent(message: message),
      );
    }
  }

  Future<void> _onDeleteConversationRequested(
    AiConversationsDeleteConversationRequested event,
    Emitter<AiConversationsState> emit,
  ) async {
    _logger.info('_onDeleteConversationRequested with id: ${event.conversationId}');
    final processingIds = Set<String>.from(state.processingConversationIds)
      ..add(event.conversationId);
    emit(state.copyWith(processingConversationIds: processingIds));

    try {
      await _aiRepository.deleteConversation(event.conversationId);
      _logger.info('_onDeleteConversationRequested success');
      await _loadConversations(emit: emit, isSilent: true);
    } on AIRepositoryException catch (e, s) {
      final message = e.message ?? 'Failed to delete conversation.';
      _logger.error('_onDeleteConversationRequested AIRepositoryException', e, s);
      emitPresentation(
        AiConversationsFailurePresentationEvent(message: message),
      );
    } catch (e, s) {
      _logger.error('_onDeleteConversationRequested unknown error', e, s);
      emitPresentation(
        AiConversationsFailurePresentationEvent(message: e.toString()),
      );
    } finally {
      final newProcessingIds = Set<String>.from(state.processingConversationIds)
        ..remove(event.conversationId);
      emit(state.copyWith(processingConversationIds: newProcessingIds));
    }
  }

  Future<void> _onRenameConversationSubmitted(
    AiConversationsRenameConversationSubmitted event,
    Emitter<AiConversationsState> emit,
  ) async {
    _logger.info('_onRenameConversationSubmitted with id: ${event.conversationId}, title: ${event.title}');
    final trimmedTitle = event.title.trim();
    if (trimmedTitle.isEmpty) {
      _logger.warning('_onRenameConversationSubmitted: empty title rejected');
      emitPresentation(
        const AiConversationsFailurePresentationEvent(
          message: 'Conversation title cannot be empty.',
        ),
      );
      return;
    }

    final processingIds = Set<String>.from(state.processingConversationIds)
      ..add(event.conversationId);
    emit(state.copyWith(processingConversationIds: processingIds));

    try {
      await _aiRepository.renameConversation(
        event.conversationId,
        trimmedTitle,
      );
      _logger.info('_onRenameConversationSubmitted success');
      await _loadConversations(emit: emit, isSilent: true);
    } on AIRepositoryException catch (e, s) {
      final message = e.message ?? 'Failed to rename conversation.';
      _logger.error('_onRenameConversationSubmitted AIRepositoryException', e, s);
      emitPresentation(
        AiConversationsFailurePresentationEvent(message: message),
      );
    } catch (e, s) {
      _logger.error('_onRenameConversationSubmitted unknown error', e, s);
      emitPresentation(
        AiConversationsFailurePresentationEvent(message: e.toString()),
      );
    } finally {
      final newProcessingIds = Set<String>.from(state.processingConversationIds)
        ..remove(event.conversationId);
      emit(state.copyWith(processingConversationIds: newProcessingIds));
    }
  }

  Future<void> _loadConversations({
    required Emitter<AiConversationsState> emit,
    bool isSilent = false,
  }) async {
    _logger.info('_loadConversations called (isSilent: $isSilent)');
    if (!isSilent) {
      emit(
        state.copyWith(loadingState: LoadingState.loading, errorMessage: null),
      );
    }

    try {
      final conversations = await _aiRepository.getConversations();
      final sorted = List<AIConversationEntity>.from(conversations)
        ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

      _logger.info('_loadConversations success: loaded ${sorted.length} conversations');
      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          conversations: sorted,
          errorMessage: null,
        ),
      );
    } on AIRepositoryException catch (e, s) {
      final message = e.message ?? 'Failed to load conversations.';
      _logger.error('_loadConversations AIRepositoryException', e, s);
      emit(
        state.copyWith(loadingState: LoadingState.error, errorMessage: message),
      );
      emitPresentation(
        AiConversationsFailurePresentationEvent(message: message),
      );
    } catch (e, s) {
      final message = e.toString();
      _logger.error('_loadConversations unknown error', e, s);
      emit(
        state.copyWith(loadingState: LoadingState.error, errorMessage: message),
      );
      emitPresentation(
        AiConversationsFailurePresentationEvent(message: message),
      );
    }
  }
}
