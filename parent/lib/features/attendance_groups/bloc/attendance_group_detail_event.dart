part of 'attendance_group_detail_bloc.dart';

sealed class AttendanceGroupDetailEvent extends Equatable {
  const AttendanceGroupDetailEvent();

  @override
  List<Object?> get props => const [];
}

final class AttendanceGroupDetailStarted extends AttendanceGroupDetailEvent {
  final String childId;
  final String groupId;
  const AttendanceGroupDetailStarted({
    required this.childId,
    required this.groupId,
  });

  @override
  List<Object?> get props => [childId, groupId];
}

final class AttendanceGroupDetailRefreshRequested
    extends AttendanceGroupDetailEvent {
  const AttendanceGroupDetailRefreshRequested();
}
