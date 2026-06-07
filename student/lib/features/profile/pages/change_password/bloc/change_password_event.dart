part of 'change_password_bloc.dart';

sealed class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object?> get props => [];
}

final class ChangePasswordLoadEvent extends ChangePasswordEvent {
  const ChangePasswordLoadEvent();
}

final class ChangePasswordSubmitEvent extends ChangePasswordEvent {
  final String currentPassword;
  final String newPassword;

  const ChangePasswordSubmitEvent({
    required this.currentPassword,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [currentPassword, newPassword];
}
