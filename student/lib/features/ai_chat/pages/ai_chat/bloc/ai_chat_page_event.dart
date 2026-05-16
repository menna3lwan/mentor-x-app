part of 'ai_chat_page_bloc.dart';

sealed class AiChatPageEvent extends Equatable {
  const AiChatPageEvent();

  @override
  List<Object?> get props => [];
}

final class AiChatPageLoadEvent extends AiChatPageEvent {
  const AiChatPageLoadEvent();
}

final class AiChatPageSendMessage extends AiChatPageEvent {
  final String content;
  const AiChatPageSendMessage({required this.content});

  @override
  List<Object?> get props => [content];
}
