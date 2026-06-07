part of 'ai_chat_bloc.dart';

final class AiChatState extends Equatable {
  final LoadingState loadingState;
  final String? conversationId;
  final List<AIMessageEntity> messages;
  final String? errorMessage;
  final bool isTyping;

  const AiChatState({
    this.loadingState = LoadingState.initial,
    this.conversationId,
    this.messages = const [],
    this.errorMessage,
    this.isTyping = false,
  });

  static const initial = AiChatState();

  bool get isLoading => loadingState.isLoading;
  bool get isLoaded => loadingState.isLoaded;

  @override
  List<Object?> get props => [
    loadingState,
    conversationId,
    messages,
    errorMessage,
    isTyping,
  ];

  AiChatState copyWith({
    LoadingState? loadingState,
    String? conversationId,
    List<AIMessageEntity>? messages,
    String? errorMessage,
    bool? isTyping,
  }) {
    return AiChatState(
      loadingState: loadingState ?? this.loadingState,
      conversationId: conversationId ?? this.conversationId,
      messages: messages ?? this.messages,
      errorMessage: errorMessage ?? this.errorMessage,
      isTyping: isTyping ?? this.isTyping,
    );
  }
}
