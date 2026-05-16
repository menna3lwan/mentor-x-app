part of 'student_card_bloc.dart';

final class StudentCardState extends Equatable {
  final LoadingState loadingState;
  final StudentCardEntity? card;
  final StudentCardRepositoryException? exception;

  const StudentCardState({
    required this.loadingState,
    this.card,
    this.exception,
  });

  static const initial = StudentCardState(
    loadingState: LoadingState.initial,
  );

  @override
  List<Object?> get props => [loadingState, card, exception];

  StudentCardState copyWith({
    LoadingState? loadingState,
    StudentCardEntity? card,
    StudentCardRepositoryException? exception,
  }) {
    return StudentCardState(
      loadingState: loadingState ?? this.loadingState,
      card: card ?? this.card,
      exception: exception ?? this.exception,
    );
  }
}
