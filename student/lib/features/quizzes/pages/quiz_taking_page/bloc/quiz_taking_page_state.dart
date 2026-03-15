part of 'quiz_taking_page_bloc.dart';

final class QuizTakingPageState extends Equatable {
  final LoadingState loadingState;

  const QuizTakingPageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = QuizTakingPageState();

  @override
  List<Object?> get props => [loadingState];

  QuizTakingPageState copyWith({LoadingState? loadingState}) {
    return QuizTakingPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
