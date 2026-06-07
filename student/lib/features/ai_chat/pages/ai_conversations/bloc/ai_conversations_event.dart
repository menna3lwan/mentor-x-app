part of 'ai_conversations_bloc.dart';

sealed class AiConversationsEvent extends Equatable {
  const AiConversationsEvent();

  @override
  List<Object?> get props => [];
}

final class AiConversationsInitialized extends AiConversationsEvent {
  const AiConversationsInitialized();
}

final class AiConversationsRefreshed extends AiConversationsEvent {
  const AiConversationsRefreshed();
}

final class AiConversationsConversationTapped
    extends AiConversationsEvent {
  final String conversationId;

  const AiConversationsConversationTapped({required this.conversationId});

  @override
  List<Object?> get props => [conversationId];
}

final class AiConversationsCreateConversationRequested
    extends AiConversationsEvent {
  const AiConversationsCreateConversationRequested();
}

final class AiConversationsDeleteConversationRequested
    extends AiConversationsEvent {
  final String conversationId;

  const AiConversationsDeleteConversationRequested({
    required this.conversationId,
  });

  @override
  List<Object?> get props => [conversationId];
}

final class AiConversationsRenameConversationSubmitted
    extends AiConversationsEvent {
  final String conversationId;
  final String title;

  const AiConversationsRenameConversationSubmitted({
    required this.conversationId,
    required this.title,
  });

  @override
  List<Object?> get props => [conversationId, title];
}
