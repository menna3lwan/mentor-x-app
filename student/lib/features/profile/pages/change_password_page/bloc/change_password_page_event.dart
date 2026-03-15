part of 'change_password_page_bloc.dart';

sealed class ChangePasswordPageEvent extends Equatable {
  const ChangePasswordPageEvent();

  @override
  List<Object?> get props => [];
}

final class ChangePasswordPageLoadEvent extends ChangePasswordPageEvent {
  const ChangePasswordPageLoadEvent();
}
