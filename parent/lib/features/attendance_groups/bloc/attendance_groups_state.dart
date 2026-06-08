part of 'attendance_groups_bloc.dart';

enum AttendanceGroupsStatus { initial, loading, loaded, failure }

extension AttendanceGroupsStatusX on AttendanceGroupsStatus {
  bool get isInitial => this == AttendanceGroupsStatus.initial;
  bool get isLoading => this == AttendanceGroupsStatus.loading;
  bool get isLoaded => this == AttendanceGroupsStatus.loaded;
  bool get isFailure => this == AttendanceGroupsStatus.failure;
}

final class AttendanceGroupsState extends Equatable {
  final AttendanceGroupsStatus status;
  final String? childId;
  final List<ParentAttendanceGroupEntity> groups;
  final String? errorMessage;
  final bool isRefreshing;

  const AttendanceGroupsState({
    required this.status,
    this.childId,
    this.groups = const [],
    this.errorMessage,
    this.isRefreshing = false,
  });

  factory AttendanceGroupsState.initial() =>
      const AttendanceGroupsState(status: AttendanceGroupsStatus.initial);

  AttendanceGroupsState copyWith({
    AttendanceGroupsStatus? status,
    String? childId,
    List<ParentAttendanceGroupEntity>? groups,
    String? errorMessage,
    bool? isRefreshing,
  }) {
    return AttendanceGroupsState(
      status: status ?? this.status,
      childId: childId ?? this.childId,
      groups: groups ?? this.groups,
      errorMessage: errorMessage,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }

  @override
  List<Object?> get props => [
    status,
    childId,
    groups,
    errorMessage,
    isRefreshing,
  ];
}
