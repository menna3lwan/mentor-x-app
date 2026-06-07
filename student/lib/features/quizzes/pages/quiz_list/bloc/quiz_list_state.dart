part of 'quiz_list_bloc.dart';

final class QuizListState extends Equatable {
  final LoadingState loadingState;
  final List<QuizEntity> quizzes;
  final String? errorMessage;

  const QuizListState({
    this.loadingState = LoadingState.initial,
    this.quizzes = const [],
    this.errorMessage,
  });

  static const initial = QuizListState();

  @override
  List<Object?> get props => [loadingState, quizzes, errorMessage];

  QuizListState copyWith({
    LoadingState? loadingState,
    List<QuizEntity>? quizzes,
    String? errorMessage,
  }) {
    return QuizListState(
      loadingState: loadingState ?? this.loadingState,
      quizzes: quizzes ?? this.quizzes,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
