import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent/core/core.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

final class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final ParentAttendanceRepository _repository;
  final AnalyticsService _analyticsService;
  static final MentorXLogger _logger = MentorXLogger('AttendanceBloc');

  AttendanceBloc({
    required ParentAttendanceRepository repository,
    required AnalyticsService analyticsService,
  })  : _repository = repository,
        _analyticsService = analyticsService,
        super(const AttendanceState()) {
    on<AttendanceStarted>(_onStarted);
    on<AttendanceRefreshRequested>(_onRefreshRequested);
  }

  Future<void> _onRefreshRequested(
    AttendanceRefreshRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    _logger.info('Refresh requested for childId: ${event.childId}');
    add(AttendanceStarted(event.childId));
  }

  Future<void> _onStarted(
    AttendanceStarted event,
    Emitter<AttendanceState> emit,
  ) async {
    _logger.info('Started loading attendance for childId: ${event.childId}');
    emit(state.copyWith(status: AttendanceBlocStatus.loading));
    try {
      _analyticsService.logEvent(
        name: AnalyticsEvents.attendanceViewed,
        parameters: {AnalyticsParams.id: event.childId},
      );
      final results = await Future.wait([
        _repository.getAttendance(event.childId),
        _repository.getAttendanceSummary(event.childId),
      ]);

      _logger.info('Successfully loaded attendance for childId: ${event.childId}');
      emit(state.copyWith(
        status: AttendanceBlocStatus.success,
        attendanceRecords: results[0] as List<AttendanceRecordEntity>,
        attendanceSummary: results[1] as AttendanceSummaryEntity,
      ));
    } catch (e, s) {
      _logger.error('Failed to load attendance for childId: ${event.childId}', e, s);
      emit(state.copyWith(
        status: AttendanceBlocStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
