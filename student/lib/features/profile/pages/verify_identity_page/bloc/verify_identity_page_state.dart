part of 'verify_identity_page_bloc.dart';

enum VerifyIdentityStatus { initial, loading, success, error }

final class VerifyIdentityPageState extends Equatable {
  final VerifyIdentityStatus status;
  final NationalIdVerificationEntity? verification;
  final String? errorMessage;

  const VerifyIdentityPageState({
    this.status = VerifyIdentityStatus.initial,
    this.verification,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, verification, errorMessage];

  VerifyIdentityPageState copyWith({
    VerifyIdentityStatus? status,
    NationalIdVerificationEntity? verification,
    String? errorMessage,
  }) {
    return VerifyIdentityPageState(
      status: status ?? this.status,
      verification: verification ?? this.verification,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
