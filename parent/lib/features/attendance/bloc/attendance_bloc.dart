import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final ParentAttendanceRepository _repository;

  AttendanceBloc({
    required ParentAttendanceRepository repository,
  })  : _repository = repository,
        super(const AttendanceState()) {
    on<AttendanceStarted>(_onStarted);
    on<AttendanceRefreshRequested>(_onRefreshRequested);
  }

  Future<void> _onRefreshRequested(
    AttendanceRefreshRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    add(AttendanceStarted(event.childId));
  }

  Future<void> _onStarted(
    AttendanceStarted event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(status: AttendanceBlocStatus.loading));
    try {
      final results = await Future.wait([
        _repository.getAttendance(event.childId),
        _repository.getAttendanceSummary(event.childId),
      ]);

      emit(state.copyWith(
        status: AttendanceBlocStatus.success,
        attendanceRecords: results[0] as List<AttendanceRecordEntity>,
        attendanceSummary: results[1] as AttendanceSummaryEntity,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AttendanceBlocStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
