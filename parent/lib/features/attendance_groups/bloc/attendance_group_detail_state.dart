part of 'attendance_group_detail_bloc.dart';

enum AttendanceGroupDetailStatus { initial, loading, loaded, failure }

extension AttendanceGroupDetailStatusX on AttendanceGroupDetailStatus {
  bool get isInitial => this == AttendanceGroupDetailStatus.initial;
  bool get isLoading => this == AttendanceGroupDetailStatus.loading;
  bool get isLoaded => this == AttendanceGroupDetailStatus.loaded;
  bool get isFailure => this == AttendanceGroupDetailStatus.failure;
}

final class AttendanceGroupDetailState extends Equatable {
  final AttendanceGroupDetailStatus status;
  final String? childId;
  final String? groupId;
  final ParentAttendanceGroupDetailEntity? detail;
  final String? errorMessage;
  final bool isRefreshing;

  const AttendanceGroupDetailState({
    required this.status,
    this.childId,
    this.groupId,
    this.detail,
    this.errorMessage,
    this.isRefreshing = false,
  });

  factory AttendanceGroupDetailState.initial() =>
      const AttendanceGroupDetailState(
        status: AttendanceGroupDetailStatus.initial,
      );

  AttendanceGroupDetailState copyWith({
    AttendanceGroupDetailStatus? status,
    String? childId,
    String? groupId,
    ParentAttendanceGroupDetailEntity? detail,
    String? errorMessage,
    bool? isRefreshing,
  }) {
    return AttendanceGroupDetailState(
      status: status ?? this.status,
      childId: childId ?? this.childId,
      groupId: groupId ?? this.groupId,
      detail: detail ?? this.detail,
      errorMessage: errorMessage,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [
    status,
    childId,
    groupId,
    detail,
    errorMessage,
    isRefreshing,
  ];
}
