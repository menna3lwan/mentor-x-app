part of 'quiz_intro_bloc.dart';

final class QuizIntroState extends Equatable {
  final LoadingState loadingState;
  final String quizId;
  final QuizEntity? quiz;
  final QuizAttemptEntity? activeAttempt;
  final String? errorMessage;

  const QuizIntroState({
    this.loadingState = LoadingState.initial,
    required this.quizId,
    this.quiz,
    this.activeAttempt,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [
    loadingState,
    quizId,
    quiz,
    activeAttempt,
    errorMessage,
  ];

  QuizIntroState copyWith({
    LoadingState? loadingState,
    String? quizId,
    QuizEntity? quiz,
    QuizAttemptEntity? activeAttempt,
    String? errorMessage,
  }) {
    return QuizIntroState(
      loadingState: loadingState ?? this.loadingState,
      quizId: quizId ?? this.quizId,
      quiz: quiz ?? this.quiz,
      activeAttempt: activeAttempt ?? this.activeAttempt,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
