part of 'ai_chat_page_bloc.dart';

final class AiChatPageState extends Equatable {
  final LoadingState loadingState;

  const AiChatPageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = AiChatPageState();

  @override
  List<Object?> get props => [loadingState];

  AiChatPageState copyWith({LoadingState? loadingState}) {
    return AiChatPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
