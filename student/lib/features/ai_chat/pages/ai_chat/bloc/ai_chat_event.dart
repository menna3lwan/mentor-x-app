part of 'ai_chat_bloc.dart';

sealed class AiChatEvent extends Equatable {
  const AiChatEvent();

  @override
  List<Object?> get props => [];
}

final class AiChatLoadEvent extends AiChatEvent {
  const AiChatLoadEvent();
}

final class AiChatSendMessage extends AiChatEvent {
  final String content;
  const AiChatSendMessage({required this.content});

  @override
  List<Object?> get props => [content];
}
