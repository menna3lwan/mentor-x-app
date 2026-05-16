part of 'quiz_result_page_bloc.dart';

sealed class QuizResultPageEvent extends Equatable {
  const QuizResultPageEvent();

  @override
  List<Object?> get props => [];
}

final class QuizResultPageLoadEvent extends QuizResultPageEvent {
  final String attemptId;
  const QuizResultPageLoadEvent({required this.attemptId});

  @override
  List<Object?> get props => [attemptId];
}
