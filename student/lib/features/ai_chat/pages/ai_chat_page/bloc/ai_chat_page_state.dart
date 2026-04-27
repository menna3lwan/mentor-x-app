part of 'ai_chat_page_bloc.dart';

final class AiChatPageState extends Equatable {
  final LoadingState loadingState;
  final String? conversationId;
  final List<AIMessageEntity> messages;
  final String? errorMessage;
  final bool isTyping;

  const AiChatPageState({
    this.loadingState = LoadingState.initial,
    this.conversationId,
    this.messages = const [],
    this.errorMessage,
    this.isTyping = false,
  });

  static const initial = AiChatPageState();

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

  AiChatPageState copyWith({
    LoadingState? loadingState,
    String? conversationId,
    List<AIMessageEntity>? messages,
    String? errorMessage,
    bool? isTyping,
  }) {
    return AiChatPageState(
      loadingState: loadingState ?? this.loadingState,
      conversationId: conversationId ?? this.conversationId,
      messages: messages ?? this.messages,
      errorMessage: errorMessage ?? this.errorMessage,
      isTyping: isTyping ?? this.isTyping,
    );
  }
}
