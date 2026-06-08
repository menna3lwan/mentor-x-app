part of 'package:mentorx_core/mentorx_core.dart';

/// Input payload for a parent-initiated account-deletion request.
///
/// Modelled as a value object so the repository contract is explicit about
/// what the backend will receive — and so the bloc can validate the shape
/// before submitting.
class ParentAccountDeletionRequest extends Equatable {
  /// Free-text reason the parent supplied. Optional — the backend should
  /// accept the request without it, but having it helps product-side
  /// analytics on why parents leave.
  final String? reason;

  /// Parent's typed confirmation phrase (e.g. they type the word `DELETE`).
  /// Treated as a UI safety-rail, not a backend secret. The repository
  /// MAY pass it through; the bloc is responsible for verifying the user
  /// actually typed the expected token before submitting.
  final String? confirmationPhrase;

  /// `true` once the parent has ticked the "I understand this is permanent"
  /// checkbox. The bloc gates submission on this; we still forward it so
  /// the backend can store the consent record.
  final bool acknowledgedPermanent;

  /// `true` when the parent asked for an export of their data before
  /// deletion. Backend may queue an email job; UI just surfaces a toast.
  final bool requestDataExport;

  const ParentAccountDeletionRequest({
    this.reason,
    this.confirmationPhrase,
    this.acknowledgedPermanent = false,
    this.requestDataExport = false,
  });

  ParentAccountDeletionRequest copyWith({
    String? reason,
    String? confirmationPhrase,
    bool? acknowledgedPermanent,
    bool? requestDataExport,
  }) {
    return ParentAccountDeletionRequest(
      reason: reason ?? this.reason,
      confirmationPhrase: confirmationPhrase ?? this.confirmationPhrase,
      acknowledgedPermanent:
          acknowledgedPermanent ?? this.acknowledgedPermanent,
      requestDataExport: requestDataExport ?? this.requestDataExport,
    );
  }

  Map<String, dynamic> toJson() => {
    if (reason != null && reason!.trim().isNotEmpty) 'reason': reason!.trim(),
    'acknowledgedPermanent': acknowledgedPermanent,
    if (requestDataExport) 'requestDataExport': true,
  };

  @override
  List<Object?> get props => [
    reason,
    confirmationPhrase,
    acknowledgedPermanent,
    requestDataExport,
  ];
}
