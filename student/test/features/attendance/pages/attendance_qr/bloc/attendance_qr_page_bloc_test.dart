import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_attendance_repository/mock_attendance_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/attendance/pages/attendance_qr/bloc/attendance_qr_bloc.dart';

class MockAnalyticsService implements AnalyticsService {
  @override
  Future<void> initialize() async {}
  @override
  Future<void> logEvent({required String name, Map<String, Object?>? parameters}) async {}
  @override
  Future<void> setCurrentScreen({required String screenName, String? screenClassOverride}) async {}
  @override
  Future<void> setUserId(String? id) async {}
  @override
  Future<void> setUserProperty({required String name, required String? value}) async {}
  @override
  Future<void> resetAnalyticsData() async {}
}


void main() {
  late AnalyticsService analyticsService;
  late MockAttendanceRepository attendanceRepository;

  setUp(() {
    analyticsService = MockAnalyticsService();
    attendanceRepository = const MockAttendanceRepository(delay: Duration.zero);
  });

  group('AttendanceQrBloc', () {
    blocTest<AttendanceQrBloc, AttendanceQrState>(
      'emits [loading, loaded] when load event is added',
      build: () => AttendanceQrBloc(attendanceRepository: attendanceRepository,
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const AttendanceQrLoadEvent()),
      expect: () => [
        isA<AttendanceQrState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<AttendanceQrState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );

    blocTest<AttendanceQrBloc, AttendanceQrState>(
      'initial state has LoadingState.initial',
      build: () => AttendanceQrBloc(attendanceRepository: attendanceRepository,
        analyticsService: analyticsService,
      ),
      verify: (bloc) {
        expect(bloc.state, AttendanceQrState.initial);
        expect(bloc.state.loadingState, LoadingState.initial);
      },
    );
  });
}
