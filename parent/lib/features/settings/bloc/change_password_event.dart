part of 'change_password_bloc.dart';

sealed class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object?> get props => const [];
}

final class ChangePasswordCurrentChanged extends ChangePasswordEvent {
  final String value;
  const ChangePasswordCurrentChanged(this.value);

  @override
  List<Object?> get props => [value];
}

final class ChangePasswordNewChanged extends ChangePasswordEvent {
  final String value;
  const ChangePasswordNewChanged(this.value);

  @override
  List<Object?> get props => [value];
}

final class ChangePasswordConfirmChanged extends ChangePasswordEvent {
  final String value;
  const ChangePasswordConfirmChanged(this.value);

  @override
  List<Object?> get props => [value];
}

final class ChangePasswordSubmitted extends ChangePasswordEvent {
  const ChangePasswordSubmitted();
}
