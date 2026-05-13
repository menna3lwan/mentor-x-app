import 'package:mentorx_core/mentorx_core.dart';

final class MockParentAttendanceRepository implements ParentAttendanceRepository {
  final Duration delay;

  MockParentAttendanceRepository({
    this.delay = const Duration(milliseconds: 800),
  });

  @override
  Future<void> initialize() async {}

  @override
  Future<List<AttendanceRecordEntity>> getAttendance(
    String childId, {
    DateTime? from,
    DateTime? to,
  }) async {
    await Future.delayed(delay);
    return [
      AttendanceRecordEntity(
        id: 'att_1',
        date: DateTime.now().subtract(const Duration(days: 1)),
        courseName: 'Mathematics',
        sessionTitle: 'Session 12',
        status: AttendanceStatus.present,
      ),
      AttendanceRecordEntity(
        id: 'att_2',
        date: DateTime.now().subtract(const Duration(days: 3)),
        courseName: 'Physics',
        sessionTitle: 'Session 8',
        status: AttendanceStatus.absent,
      ),
    ];
  }

  @override
  Future<AttendanceSummaryEntity> getAttendanceSummary(
    String childId, {
    DateTime? from,
    DateTime? to,
  }) async {
    await Future.delayed(delay);
    return const AttendanceSummaryEntity(
      totalSessions: 20,
      present: 18,
      late: 0,
      absent: 2,
      excused: 0,
      attendanceRate: 0.9,
    );
  }

  @override
  Future<List<GroupEntity>> getChildGroups(String childId) async {
    await Future.delayed(delay);
    return [
      GroupEntity(id: 'g-parent-1', name: 'Physics Group $childId'),
      GroupEntity(id: 'g-parent-2', name: 'Math Group $childId'),
    ];
  }
}
