part of 'quiz_intro_bloc.dart';

sealed class QuizIntroEvent extends Equatable {
  const QuizIntroEvent();

  @override
  List<Object?> get props => [];
}

final class QuizIntroLoadEvent extends QuizIntroEvent {
  const QuizIntroLoadEvent();
}
