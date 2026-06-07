part of 'status_pending_bloc.dart';

final class StatusPendingState extends Equatable {
  final LoadingState loadingState;
  final bool isRefreshing;
  final String? studentCode;
  final String? tenantWhatsAppNumber;

  const StatusPendingState({
    required this.loadingState,
    required this.isRefreshing,
    this.studentCode,
    this.tenantWhatsAppNumber,
  });

  static const initial = StatusPendingState(
    loadingState: LoadingState.initial,
    isRefreshing: false,
  );

  StatusPendingState copyWith({
    LoadingState? loadingState,
    bool? isRefreshing,
    String? studentCode,
    MentorXNullableValue<String?>? tenantWhatsAppNumber,
  }) {
    return StatusPendingState(
      loadingState: loadingState ?? this.loadingState,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      studentCode: studentCode ?? this.studentCode,
      tenantWhatsAppNumber: tenantWhatsAppNumber != null
          ? tenantWhatsAppNumber.value
          : this.tenantWhatsAppNumber,
    );
  }

  @override
  List<Object?> get props => [
    loadingState,
    isRefreshing,
    studentCode,
    tenantWhatsAppNumber,
  ];
}
