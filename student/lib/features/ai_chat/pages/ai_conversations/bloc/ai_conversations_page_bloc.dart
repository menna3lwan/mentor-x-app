import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';

import 'package:mentorx_student/core/core.dart';

part 'ai_conversations_page_event.dart';
part 'ai_conversations_page_state.dart';

sealed class AiConversationsPagePresentationEvent {
  const AiConversationsPagePresentationEvent();
}

final class AiConversationsPageFailurePresentationEvent
    extends AiConversationsPagePresentationEvent {
  final String message;

  const AiConversationsPageFailurePresentationEvent({required this.message});
}

final class AiConversationsPageOpenChatPresentationEvent
    extends AiConversationsPagePresentationEvent {
  const AiConversationsPageOpenChatPresentationEvent();
}

final class AiConversationsPageBloc
    extends Bloc<AiConversationsPageEvent, AiConversationsPageState>
    with
        BlocPresentationMixin<
          AiConversationsPageState,
          AiConversationsPagePresentationEvent
        > {
  final AIRepository _aiRepository;
  final AnalyticsService _analyticsService;

  AiConversationsPageBloc({
    required AIRepository aiRepository,
    required AnalyticsService analyticsService,
  }) : _aiRepository = aiRepository,
       _analyticsService = analyticsService,
       super(AiConversationsPageState.initial) {
    on<AiConversationsPageInitialized>(_onInitialized);
    on<AiConversationsPageRefreshed>(_onRefreshed);
    on<AiConversationsPageConversationTapped>(_onConversationTapped);
    on<AiConversationsPageCreateConversationRequested>(
      _onCreateConversationRequested,
    );
    on<AiConversationsPageDeleteConversationRequested>(
      _onDeleteConversationRequested,
    );
    on<AiConversationsPageRenameConversationSubmitted>(
      _onRenameConversationSubmitted,
    );
  }

  Future<void> _onInitialized(
    AiConversationsPageInitialized event,
    Emitter<AiConversationsPageState> emit,
  ) async {
    _analyticsService.logEvent(name: AnalyticsEvents.aiConversationsViewed);
    await _loadConversations(emit: emit);
  }

  Future<void> _onRefreshed(
    AiConversationsPageRefreshed event,
    Emitter<AiConversationsPageState> emit,
  ) async {
    await _loadConversations(emit: emit);
  }

  Future<void> _onConversationTapped(
    AiConversationsPageConversationTapped event,
    Emitter<AiConversationsPageState> emit,
  ) async {
    emitPresentation(const AiConversationsPageOpenChatPresentationEvent());
  }

  Future<void> _onCreateConversationRequested(
    AiConversationsPageCreateConversationRequested event,
    Emitter<AiConversationsPageState> emit,
  ) async {
    emit(
      state.copyWith(loadingState: LoadingState.loading, errorMessage: null),
    );

    try {
      await _aiRepository.createConversation();
      emitPresentation(const AiConversationsPageOpenChatPresentationEvent());
      await _loadConversations(emit: emit, isSilent: true);
    } on AIRepositoryException catch (e) {
      final message = e.message ?? 'Failed to create conversation.';
      emit(
        state.copyWith(loadingState: LoadingState.error, errorMessage: message),
      );
      emitPresentation(
        AiConversationsPageFailurePresentationEvent(message: message),
      );
    } catch (e) {
      final message = e.toString();
      emit(
        state.copyWith(loadingState: LoadingState.error, errorMessage: message),
      );
      emitPresentation(
        AiConversationsPageFailurePresentationEvent(message: message),
      );
    }
  }

  Future<void> _onDeleteConversationRequested(
    AiConversationsPageDeleteConversationRequested event,
    Emitter<AiConversationsPageState> emit,
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
        AiConversationsPageFailurePresentationEvent(message: message),
      );
    } catch (e) {
      emitPresentation(
        AiConversationsPageFailurePresentationEvent(message: e.toString()),
      );
    } finally {
      final newProcessingIds = Set<String>.from(state.processingConversationIds)
        ..remove(event.conversationId);
      emit(state.copyWith(processingConversationIds: newProcessingIds));
    }
  }

  Future<void> _onRenameConversationSubmitted(
    AiConversationsPageRenameConversationSubmitted event,
    Emitter<AiConversationsPageState> emit,
  ) async {
    final trimmedTitle = event.title.trim();
    if (trimmedTitle.isEmpty) {
      emitPresentation(
        const AiConversationsPageFailurePresentationEvent(
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
        AiConversationsPageFailurePresentationEvent(message: message),
      );
    } catch (e) {
      emitPresentation(
        AiConversationsPageFailurePresentationEvent(message: e.toString()),
      );
    } finally {
      final newProcessingIds = Set<String>.from(state.processingConversationIds)
        ..remove(event.conversationId);
      emit(state.copyWith(processingConversationIds: newProcessingIds));
    }
  }

  Future<void> _loadConversations({
    required Emitter<AiConversationsPageState> emit,
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
        AiConversationsPageFailurePresentationEvent(message: message),
      );
    } catch (e) {
      final message = e.toString();
      emit(
        state.copyWith(loadingState: LoadingState.error, errorMessage: message),
      );
      emitPresentation(
        AiConversationsPageFailurePresentationEvent(message: message),
      );
    }
  }
}
