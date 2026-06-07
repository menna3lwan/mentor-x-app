part of 'quiz_list_bloc.dart';

sealed class QuizListEvent extends Equatable {
  const QuizListEvent();

  @override
  List<Object?> get props => [];
}

final class QuizListLoadEvent extends QuizListEvent {
  const QuizListLoadEvent();
}
