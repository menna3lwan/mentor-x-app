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
    _analyticsService.logEvent(name: AnalyticsEvents.aiConversationsViewed);
    await _loadConversations(emit: emit);
  }

  Future<void> _onRefreshed(
    AiConversationsRefreshed event,
    Emitter<AiConversationsState> emit,
  ) async {
    await _loadConversations(emit: emit);
  }

  Future<void> _onConversationTapped(
    AiConversationsConversationTapped event,
    Emitter<AiConversationsState> emit,
  ) async {
    emitPresentation(const AiConversationsOpenChatPresentationEvent());
  }

  Future<void> _onCreateConversationRequested(
    AiConversationsCreateConversationRequested event,
    Emitter<AiConversationsState> emit,
  ) async {
    emit(
      state.copyWith(loadingState: LoadingState.loading, errorMessage: null),
    );

    try {
      await _aiRepository.createConversation();
      emitPresentation(const AiConversationsOpenChatPresentationEvent());
      await _loadConversations(emit: emit, isSilent: true);
    } on AIRepositoryException catch (e) {
      final message = e.message ?? 'Failed to create conversation.';
      emit(
        state.copyWith(loadingState: LoadingState.error, errorMessage: message),
      );
      emitPresentation(
        AiConversationsFailurePresentationEvent(message: message),
      );
    } catch (e) {
      final message = e.toString();
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
    final processingIds = Set<String>.from(state.processingConversationIds)
      ..add(event.conversationId);
    emit(state.copyWith(processingConversationIds: processingIds));

    try {
      await _aiRepository.deleteConversation(event.conversationId);
      await _loadConversations(emit: emit, isSilent: true);
    } on AIRepositoryException catch (e) {
      final message = e.message ?? 'Failed to delete conversation.';
      emitPresentation(
        AiConversationsFailurePresentationEvent(message: message),
      );
    } catch (e) {
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
    final trimmedTitle = event.title.trim();
    if (trimmedTitle.isEmpty) {
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
      await _loadConversations(emit: emit, isSilent: true);
    } on AIRepositoryException catch (e) {
      final message = e.message ?? 'Failed to rename conversation.';
      emitPresentation(
        AiConversationsFailurePresentationEvent(message: message),
      );
    } catch (e) {
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
    if (!isSilent) {
      emit(
        state.copyWith(loadingState: LoadingState.loading, errorMessage: null),
      );
    }

    try {
      final conversations = await _aiRepository.getConversations();
      final sorted = List<AIConversationEntity>.from(conversations)
        ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          conversations: sorted,
          errorMessage: null,
        ),
      );
    } on AIRepositoryException catch (e) {
      final message = e.message ?? 'Failed to load conversations.';
      emit(
        state.copyWith(loadingState: LoadingState.error, errorMessage: message),
      );
      emitPresentation(
        AiConversationsFailurePresentationEvent(message: message),
      );
    } catch (e) {
      final message = e.toString();
      emit(
        state.copyWith(loadingState: LoadingState.error, errorMessage: message),
      );
      emitPresentation(
        AiConversationsFailurePresentationEvent(message: message),
      );
    }
  }
}
