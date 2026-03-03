part of 'forget_password_bloc.dart';

sealed class ForgetPasswordEvent extends Equatable {
  const ForgetPasswordEvent();

  @override
  List<Object?> get props => [];
}

final class ForgetPasswordSubmittedEvent extends ForgetPasswordEvent {
  final String phoneNumber;

  const ForgetPasswordSubmittedEvent({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}
