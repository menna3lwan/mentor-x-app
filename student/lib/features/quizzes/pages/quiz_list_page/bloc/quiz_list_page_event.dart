part of 'quiz_list_page_bloc.dart';

sealed class QuizListPageEvent extends Equatable {
  const QuizListPageEvent();

  @override
  List<Object?> get props => [];
}

final class QuizListPageLoadEvent extends QuizListPageEvent {
  const QuizListPageLoadEvent();
}
