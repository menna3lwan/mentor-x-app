part of 'quiz_intro_page_bloc.dart';

final class QuizIntroPageState extends Equatable {
  final LoadingState loadingState;

  const QuizIntroPageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = QuizIntroPageState();

  @override
  List<Object?> get props => [loadingState];

  QuizIntroPageState copyWith({LoadingState? loadingState}) {
    return QuizIntroPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
