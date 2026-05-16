part of 'student_card_bloc.dart';

sealed class StudentCardEvent extends Equatable {
  const StudentCardEvent();
  @override
  List<Object?> get props => [];
}

final class StudentCardLoadEvent extends StudentCardEvent {
  const StudentCardLoadEvent();
}
