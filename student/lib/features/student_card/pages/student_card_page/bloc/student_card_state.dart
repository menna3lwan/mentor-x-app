part of 'student_card_bloc.dart';

final class StudentCardState extends Equatable {
  final LoadingState loadingState;
  final StudentCardEntity? card;

  const StudentCardState({
    required this.loadingState,
    this.card,
  });

  static const initial = StudentCardState(
    loadingState: LoadingState.initial,
  );

  @override
  List<Object?> get props => [loadingState, card];

  StudentCardState copyWith({
    LoadingState? loadingState,
    StudentCardEntity? card,
  }) {
    return StudentCardState(
      loadingState: loadingState ?? this.loadingState,
      card: card ?? this.card,
    );
  }
}
