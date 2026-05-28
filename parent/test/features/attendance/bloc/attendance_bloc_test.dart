import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:parent/features/attendance/bloc/attendance_bloc.dart';

class _MockAttendanceRepository extends Mock
    implements ParentAttendanceRepository {}

void main() {
  late _MockAttendanceRepository repo;
  const childId = 'child-1';

  const summary = AttendanceSummaryEntity(
    attendanceRate: 0.92,
    present: 23,
    absent: 1,
    late: 1,
    excused: 0,
  );

  AttendanceBloc buildBloc() => AttendanceBloc(repository: repo);

  void stubAllSuccess() {
    when(() => repo.getAttendance(childId))
        .thenAnswer((_) async => const <AttendanceRecordEntity>[]);
    when(() => repo.getAttendanceSummary(childId))
        .thenAnswer((_) async => summary);
  }

  setUp(() {
    repo = _MockAttendanceRepository();
  });

  group('AttendanceBloc.AttendanceStarted', () {
    blocTest<AttendanceBloc, AttendanceState>(
      'loads both sections on first start',
      setUp: stubAllSuccess,
      build: buildBloc,
      act: (bloc) => bloc.add(const AttendanceStarted(childId)),
      verify: (bloc) {
        expect(bloc.state.childId, equals(childId));
        expect(bloc.state.recordsSection.isLoaded, isTrue);
        expect(bloc.state.summarySection.isLoaded, isTrue);
      },
    );

    blocTest<AttendanceBloc, AttendanceState>(
      'records fetch failure leaves section in failure but keeps summary',
      setUp: () {
        when(() => repo.getAttendance(childId)).thenThrow(Exception('500'));
        when(() => repo.getAttendanceSummary(childId))
            .thenAnswer((_) async => summary);
      },
      build: buildBloc,
      act: (bloc) => bloc.add(const AttendanceStarted(childId)),
      verify: (bloc) {
        expect(bloc.state.recordsSection.isFailure, isTrue);
        expect(bloc.state.summarySection.isLoaded, isTrue);
      },
    );

    blocTest<AttendanceBloc, AttendanceState>(
      'repeated start with same child is a no-op',
      setUp: stubAllSuccess,
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const AttendanceStarted(childId));
        await Future<void>.delayed(const Duration(milliseconds: 20));
        bloc.add(const AttendanceStarted(childId));
      },
      wait: const Duration(milliseconds: 50),
      verify: (_) {
        verify(() => repo.getAttendance(childId)).called(1);
        verify(() => repo.getAttendanceSummary(childId)).called(1);
      },
    );
  });

  group('AttendanceBloc.AttendanceRefreshRequested', () {
    blocTest<AttendanceBloc, AttendanceState>(
      'rapid refresh taps are dropped',
      setUp: stubAllSuccess,
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const AttendanceRefreshRequested(childId));
        bloc.add(const AttendanceRefreshRequested(childId));
      },
      wait: const Duration(milliseconds: 50),
      verify: (_) {
        verify(() => repo.getAttendance(childId)).called(1);
      },
    );
  });

  group('AttendanceBloc.AttendanceRetrySectionRequested', () {
    blocTest<AttendanceBloc, AttendanceState>(
      'retry records refetches records only',
      setUp: stubAllSuccess,
      build: buildBloc,
      act: (bloc) async {
        bloc.add(const AttendanceStarted(childId));
        await Future<void>.delayed(const Duration(milliseconds: 20));
        bloc.add(
          const AttendanceRetrySectionRequested(AttendanceSection.records),
        );
      },
      wait: const Duration(milliseconds: 50),
      verify: (_) {
        verify(() => repo.getAttendance(childId)).called(2);
        verify(() => repo.getAttendanceSummary(childId)).called(1);
      },
    );

    blocTest<AttendanceBloc, AttendanceState>(
      'retry without a selected child is a no-op',
      build: buildBloc,
      act: (bloc) => bloc.add(
        const AttendanceRetrySectionRequested(AttendanceSection.records),
      ),
      verify: (_) {
        verifyNever(() => repo.getAttendance(any()));
      },
    );
  });
}
