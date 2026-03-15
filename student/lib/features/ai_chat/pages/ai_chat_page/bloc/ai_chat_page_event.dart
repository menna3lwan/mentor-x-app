part of 'ai_chat_page_bloc.dart';

sealed class AiChatPageEvent extends Equatable {
  const AiChatPageEvent();

  @override
  List<Object?> get props => [];
}

final class AiChatPageLoadEvent extends AiChatPageEvent {
  const AiChatPageLoadEvent();
}
