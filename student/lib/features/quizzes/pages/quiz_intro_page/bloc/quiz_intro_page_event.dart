part of 'quiz_intro_page_bloc.dart';

sealed class QuizIntroPageEvent extends Equatable {
  const QuizIntroPageEvent();

  @override
  List<Object?> get props => [];
}

final class QuizIntroPageLoadEvent extends QuizIntroPageEvent {
  const QuizIntroPageLoadEvent();
}
