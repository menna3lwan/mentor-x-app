part of 'package:mentorx_core/mentorx_core.dart';

/// Snapshot of the parent account's review state.
///
/// Returned by `GET /api/auth/pending-status` and the data layer of the
/// `Pending Account` flow. The same enum [ParentStatus] is reused so
/// downstream consumers (`AppAuthenticationCubit`, redirect guards) don't
/// have to translate between two different vocabularies.
class ParentAccountStatusEntity extends Equatable {
  final ParentStatus status;

  /// Why the account was rejected or suspended (if applicable). Backend
  /// may return this in Arabic — UI should display verbatim.
  final String? rejectionReason;

  /// Human-readable label like "Pending review" — used as a banner copy
  /// fallback when the backend supplies its own message.
  final String? message;

  /// When the parent submitted the account for review. Useful for
  /// "submitted on …" labels.
  final DateTime? submittedAt;

  /// Estimated time by which the review should be completed.
  final DateTime? estimatedReviewBy;

  /// Contact channel the parent can reach out to (phone or email) while
  /// the account is pending.
  final String? supportContact;

  const ParentAccountStatusEntity({
    required this.status,
    this.rejectionReason,
    this.message,
    this.submittedAt,
    this.estimatedReviewBy,
    this.supportContact,
  });

  bool get isPending => status == ParentStatus.pending;
  bool get isActive => status == ParentStatus.active;
  bool get isRejectedOrSuspended =>
      status == ParentStatus.inactive || status == ParentStatus.suspended;

  static const placeholder = ParentAccountStatusEntity(
    status: ParentStatus.pending,
  );

  @override
  List<Object?> get props => [
    status,
    rejectionReason,
    message,
    submittedAt,
    estimatedReviewBy,
    supportContact,
  ];

  ParentAccountStatusEntity copyWith({
    ParentStatus? status,
    String? rejectionReason,
    String? message,
    DateTime? submittedAt,
    DateTime? estimatedReviewBy,
    String? supportContact,
  }) {
    return ParentAccountStatusEntity(
      status: status ?? this.status,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      message: message ?? this.message,
      submittedAt: submittedAt ?? this.submittedAt,
      estimatedReviewBy: estimatedReviewBy ?? this.estimatedReviewBy,
      supportContact: supportContact ?? this.supportContact,
    );
  }
}
