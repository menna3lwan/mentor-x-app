part of 'ai_conversations_page_bloc.dart';

final class AiConversationsPageState extends Equatable {
  final LoadingState loadingState;
  final List<AIConversationEntity> conversations;
  final Set<String> processingConversationIds;
  final String? errorMessage;

  const AiConversationsPageState({
    required this.loadingState,
    required this.conversations,
    required this.processingConversationIds,
    this.errorMessage,
  });

  static const initial = AiConversationsPageState(
    loadingState: LoadingState.initial,
    conversations: <AIConversationEntity>[],
    processingConversationIds: <String>{},
  );

  AiConversationsPageState copyWith({
    LoadingState? loadingState,
    List<AIConversationEntity>? conversations,
    Set<String>? processingConversationIds,
    String? errorMessage,
  }) {
    return AiConversationsPageState(
      loadingState: loadingState ?? this.loadingState,
      conversations: conversations ?? this.conversations,
      processingConversationIds:
          processingConversationIds ?? this.processingConversationIds,
      errorMessage: errorMessage,
    );
  }

  bool get isLoading =>
      loadingState.isLoading || loadingState == LoadingState.initial;

  @override
  List<Object?> get props => [
    loadingState,
    conversations,
    processingConversationIds,
    errorMessage,
  ];
}
