part of 'quiz_list_page_bloc.dart';

final class QuizListPageState extends Equatable {
  final LoadingState loadingState;

  const QuizListPageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = QuizListPageState();

  @override
  List<Object?> get props => [loadingState];

  QuizListPageState copyWith({LoadingState? loadingState}) {
    return QuizListPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
