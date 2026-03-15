import 'dart:async';

import 'package:mentorx_core/mentorx_core.dart';
import 'package:mock_data/mock_data.dart';

final class MockAttendanceRepository implements AttendanceRepository {
  final Duration delay;

  const MockAttendanceRepository({required this.delay});

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
    int page = 1,
    int limit = 20,
  }) async {
    await Future<void>.delayed(delay);
    return MockAttendanceGenerator.records();
  }

  @override
  Future<AttendanceRecordEntity> checkIn(String qrData) async {
    await Future<void>.delayed(delay);
    return MockAttendanceGenerator.checkInResult(qrData);
  }
}
