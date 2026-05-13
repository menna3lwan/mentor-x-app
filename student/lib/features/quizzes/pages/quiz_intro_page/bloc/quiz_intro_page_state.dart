part of 'quiz_intro_page_bloc.dart';

final class QuizIntroPageState extends Equatable {
  final LoadingState loadingState;
  final String quizId;
  final QuizEntity? quiz;
  final String? errorMessage;

  const QuizIntroPageState({
    this.loadingState = LoadingState.initial,
    required this.quizId,
    this.quiz,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [loadingState, quizId, quiz, errorMessage];

  QuizIntroPageState copyWith({
    LoadingState? loadingState,
    String? quizId,
    QuizEntity? quiz,
    String? errorMessage,
  }) {
    return QuizIntroPageState(
      loadingState: loadingState ?? this.loadingState,
      quizId: quizId ?? this.quizId,
      quiz: quiz ?? this.quiz,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
