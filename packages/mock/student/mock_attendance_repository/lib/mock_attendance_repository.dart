import 'dart:async';

import 'package:mentorx_core/mentorx_core.dart';
import 'package:mock_data/mock_data.dart';

final class MockAttendanceRepository implements AttendanceRepository {
  final Duration delay;

  const MockAttendanceRepository({required this.delay});

  @override
  Future<void> initialize() async {}

  @override
  Future<AttendanceSummaryEntity> getSummary({
    DateTime? from,
    DateTime? to,
  }) async {
    await Future<void>.delayed(delay);
    return MockAttendanceGenerator.summary();
  }

  @override
  Future<List<AttendanceRecordEntity>> getRecords({
    DateTime? from,
    DateTime? to,
    String? courseId,
    MentorXPaginationInfo? paginationInfo,
  }) async {
    await Future<void>.delayed(delay);
    return MockAttendanceGenerator.records();
  }

  @override
  Future<AttendanceRecordEntity> checkIn(String qrData) async {
    await Future<void>.delayed(delay);
    return MockAttendanceGenerator.checkInResult(qrData);
  }

  @override
  Future<AttendanceRecordEntity> scanCenterQr({
    required String qrToken,
    required String weekId,
  }) async {
    await Future<void>.delayed(delay);
    return MockAttendanceGenerator.checkInResult(qrToken);
  }

  @override
  Future<AttendanceRecordEntity?> getLessonAttendance(String weekId) async {
    await Future<void>.delayed(delay);
    final records = MockAttendanceGenerator.records();
    return records.firstOrNull;
  }

  @override
  Future<List<GroupEntity>> getMyGroups() async {
    await Future<void>.delayed(delay);
    return const [
      GroupEntity(id: 'g-1', name: 'Physics Group A'),
      GroupEntity(id: 'g-2', name: 'Math Group B'),
    ];
  }

  @override
  Future<Map<String, dynamic>> getGroupBrief(String groupId) async {
    await Future<void>.delayed(delay);
    return {'id': 'g-1', 'name': 'Physics Group A'};
  }
}
