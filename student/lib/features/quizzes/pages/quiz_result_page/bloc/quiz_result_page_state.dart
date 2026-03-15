part of 'quiz_result_page_bloc.dart';

final class QuizResultPageState extends Equatable {
  final LoadingState loadingState;

  const QuizResultPageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = QuizResultPageState();

  @override
  List<Object?> get props => [loadingState];

  QuizResultPageState copyWith({LoadingState? loadingState}) {
    return QuizResultPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
