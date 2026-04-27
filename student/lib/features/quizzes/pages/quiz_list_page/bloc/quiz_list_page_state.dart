part of 'quiz_list_page_bloc.dart';

final class QuizListPageState extends Equatable {
  final LoadingState loadingState;
  final List<QuizEntity> quizzes;
  final String? errorMessage;

  const QuizListPageState({
    this.loadingState = LoadingState.initial,
    this.quizzes = const [],
    this.errorMessage,
  });

  static const initial = QuizListPageState();

  @override
  List<Object?> get props => [loadingState, quizzes, errorMessage];

  QuizListPageState copyWith({
    LoadingState? loadingState,
    List<QuizEntity>? quizzes,
    String? errorMessage,
  }) {
    return QuizListPageState(
      loadingState: loadingState ?? this.loadingState,
      quizzes: quizzes ?? this.quizzes,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
