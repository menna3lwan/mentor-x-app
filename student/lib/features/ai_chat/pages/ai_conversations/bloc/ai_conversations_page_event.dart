part of 'ai_conversations_page_bloc.dart';

sealed class AiConversationsPageEvent extends Equatable {
  const AiConversationsPageEvent();

  @override
  List<Object?> get props => [];
}

final class AiConversationsPageInitialized extends AiConversationsPageEvent {
  const AiConversationsPageInitialized();
}

final class AiConversationsPageRefreshed extends AiConversationsPageEvent {
  const AiConversationsPageRefreshed();
}

final class AiConversationsPageConversationTapped
    extends AiConversationsPageEvent {
  final String conversationId;

  const AiConversationsPageConversationTapped({required this.conversationId});

  @override
  List<Object?> get props => [conversationId];
}

final class AiConversationsPageCreateConversationRequested
    extends AiConversationsPageEvent {
  const AiConversationsPageCreateConversationRequested();
}

final class AiConversationsPageDeleteConversationRequested
    extends AiConversationsPageEvent {
  final String conversationId;

  const AiConversationsPageDeleteConversationRequested({
    required this.conversationId,
  });

  @override
  List<Object?> get props => [conversationId];
}

final class AiConversationsPageRenameConversationSubmitted
    extends AiConversationsPageEvent {
  final String conversationId;
  final String title;

  const AiConversationsPageRenameConversationSubmitted({
    required this.conversationId,
    required this.title,
  });

  @override
  List<Object?> get props => [conversationId, title];
}
