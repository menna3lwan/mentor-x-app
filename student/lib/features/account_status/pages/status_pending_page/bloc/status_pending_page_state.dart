part of 'status_pending_page_bloc.dart';

final class StatusPendingPageState extends Equatable {
  final LoadingState loadingState;
  final bool isRefreshing;
  final String? studentCode;
  final String? tenantWhatsAppNumber;

  const StatusPendingPageState({
    required this.loadingState,
    required this.isRefreshing,
    this.studentCode,
    this.tenantWhatsAppNumber,
  });

  static const initial = StatusPendingPageState(
    loadingState: LoadingState.initial,
    isRefreshing: false,
  );

  StatusPendingPageState copyWith({
    LoadingState? loadingState,
    bool? isRefreshing,
    String? studentCode,
    MentorXNullableValue<String?>? tenantWhatsAppNumber,
  }) {
    return StatusPendingPageState(
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
