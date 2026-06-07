part of 'quiz_result_bloc.dart';

sealed class QuizResultEvent extends Equatable {
  const QuizResultEvent();

  @override
  List<Object?> get props => [];
}

final class QuizResultLoadEvent extends QuizResultEvent {
  final String attemptId;
  const QuizResultLoadEvent({required this.attemptId});

  @override
  List<Object?> get props => [attemptId];
}
