part of 'quiz_result_page_bloc.dart';

final class QuizResultPageState extends Equatable {
  final LoadingState loadingState;
  final QuizAttemptEntity? result;
  final String? errorMessage;

  const QuizResultPageState({
    this.loadingState = LoadingState.initial,
    this.result,
    this.errorMessage,
  });

  static const initial = QuizResultPageState();

  @override
  List<Object?> get props => [loadingState, result, errorMessage];

  QuizResultPageState copyWith({
    LoadingState? loadingState,
    QuizAttemptEntity? result,
    String? errorMessage,
  }) {
    return QuizResultPageState(
      loadingState: loadingState ?? this.loadingState,
      result: result ?? this.result,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
