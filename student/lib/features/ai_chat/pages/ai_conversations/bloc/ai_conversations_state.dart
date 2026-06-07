part of 'ai_conversations_bloc.dart';

final class AiConversationsState extends Equatable {
  final LoadingState loadingState;
  final List<AIConversationEntity> conversations;
  final Set<String> processingConversationIds;
  final String? errorMessage;

  const AiConversationsState({
    required this.loadingState,
    required this.conversations,
    required this.processingConversationIds,
    this.errorMessage,
  });

  static const initial = AiConversationsState(
    loadingState: LoadingState.initial,
    conversations: <AIConversationEntity>[],
    processingConversationIds: <String>{},
  );

  AiConversationsState copyWith({
    LoadingState? loadingState,
    List<AIConversationEntity>? conversations,
    Set<String>? processingConversationIds,
    String? errorMessage,
  }) {
    return AiConversationsState(
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
