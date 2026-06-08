part of 'account_deletion_bloc.dart';

sealed class AccountDeletionEvent extends Equatable {
  const AccountDeletionEvent();

  @override
  List<Object?> get props => const [];
}

final class AccountDeletionReasonChanged extends AccountDeletionEvent {
  final String reason;
  const AccountDeletionReasonChanged(this.reason);

  @override
  List<Object?> get props => [reason];
}

final class AccountDeletionConfirmationChanged extends AccountDeletionEvent {
  final String value;
  const AccountDeletionConfirmationChanged(this.value);

  @override
  List<Object?> get props => [value];
}

final class AccountDeletionAcknowledgementToggled extends AccountDeletionEvent {
  final bool value;
  const AccountDeletionAcknowledgementToggled(this.value);

  @override
  List<Object?> get props => [value];
}

final class AccountDeletionDataExportToggled extends AccountDeletionEvent {
  final bool value;
  const AccountDeletionDataExportToggled(this.value);

  @override
  List<Object?> get props => [value];
}

final class AccountDeletionSubmitted extends AccountDeletionEvent {
  const AccountDeletionSubmitted();
}
