part of 'change_password_page_bloc.dart';

sealed class ChangePasswordPageEvent extends Equatable {
  const ChangePasswordPageEvent();

  @override
  List<Object?> get props => [];
}

final class ChangePasswordPageLoadEvent extends ChangePasswordPageEvent {
  const ChangePasswordPageLoadEvent();
}

final class ChangePasswordPageSubmitEvent extends ChangePasswordPageEvent {
  final String currentPassword;
  final String newPassword;

  const ChangePasswordPageSubmitEvent({
    required this.currentPassword,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [currentPassword, newPassword];
}
