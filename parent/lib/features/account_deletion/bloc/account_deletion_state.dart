part of 'account_deletion_bloc.dart';

enum AccountDeletionStatus { idle, submitting, success, failure }

extension AccountDeletionStatusX on AccountDeletionStatus {
  bool get isIdle => this == AccountDeletionStatus.idle;
  bool get isSubmitting => this == AccountDeletionStatus.submitting;
  bool get isSuccess => this == AccountDeletionStatus.success;
  bool get isFailure => this == AccountDeletionStatus.failure;
}

final class AccountDeletionState extends Equatable {
  final AccountDeletionStatus status;
  final String reason;
  final String confirmationPhrase;
  final bool acknowledgedPermanent;
  final bool requestDataExport;

  /// Locale-specific token the user must type verbatim before submission
  /// is allowed (e.g. "DELETE" in English, "حذف" in Arabic). Stored in
  /// state so the bloc — not the UI — owns the validation rule.
  final String expectedPhrase;

  const AccountDeletionState({
    required this.status,
    required this.reason,
    required this.confirmationPhrase,
    required this.acknowledgedPermanent,
    required this.requestDataExport,
    required this.expectedPhrase,
  });

  factory AccountDeletionState.initial({required String expectedPhrase}) =>
      AccountDeletionState(
        status: AccountDeletionStatus.idle,
        reason: '',
        confirmationPhrase: '',
        acknowledgedPermanent: false,
        requestDataExport: false,
        expectedPhrase: expectedPhrase,
      );

  bool get isConfirmationPhraseValid =>
      confirmationPhrase.trim().toLowerCase() ==
      expectedPhrase.trim().toLowerCase();

  bool get canSubmit =>
      status.isIdle && acknowledgedPermanent && isConfirmationPhraseValid;

  AccountDeletionState copyWith({
    AccountDeletionStatus? status,
    String? reason,
    String? confirmationPhrase,
    bool? acknowledgedPermanent,
    bool? requestDataExport,
    String? expectedPhrase,
  }) {
    return AccountDeletionState(
      status: status ?? this.status,
      reason: reason ?? this.reason,
      confirmationPhrase: confirmationPhrase ?? this.confirmationPhrase,
      acknowledgedPermanent:
          acknowledgedPermanent ?? this.acknowledgedPermanent,
      requestDataExport: requestDataExport ?? this.requestDataExport,
      expectedPhrase: expectedPhrase ?? this.expectedPhrase,
    );
  }

  @override
  List<Object?> get props => [
    status,
    reason,
    confirmationPhrase,
    acknowledgedPermanent,
    requestDataExport,
    expectedPhrase,
  ];
}
