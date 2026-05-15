import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

sealed class AttendancePresentationEvent {
  const AttendancePresentationEvent();
}

final class AttendanceFailurePresentationEvent
    extends AttendancePresentationEvent {
  final String message;
  const AttendanceFailurePresentationEvent({required this.message});
}

/// Drives the parent attendance-monitor screen.
final class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState>
    with
        BlocPresentationMixin<AttendanceState, AttendancePresentationEvent> {
  final ParentAttendanceRepository _repository;

  AttendanceBloc({required ParentAttendanceRepository repository})
      : _repository = repository,
        super(AttendanceState.initial()) {
    on<AttendanceStarted>(_onStarted);
    on<AttendanceRefreshRequested>(_onRefreshRequested);
    on<AttendanceRetrySectionRequested>(_onRetrySection);
  }

  Future<void> _onStarted(
    AttendanceStarted event,
    Emitter<AttendanceState> emit,
  ) async {
    if (state.childId == event.childId &&
        (state.recordsSection.isLoaded ||
            state.recordsSection.isLoading)) {
      return;
    }
    emit(state.copyWith(childId: event.childId));
    await _loadAll(emit, event.childId);
  }

  Future<void> _onRefreshRequested(
    AttendanceRefreshRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    emit(state.copyWith(isRefreshing: true, childId: event.childId));
    await _loadAll(emit, event.childId);
    emit(state.copyWith(isRefreshing: false));
  }

  Future<void> _onRetrySection(
    AttendanceRetrySectionRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    final childId = state.childId;
    if (childId == null) return;

    switch (event.section) {
      case AttendanceSection.records:
        emit(state.copyWith(
          recordsSection: state.recordsSection.toLoading(),
        ));
        await _loadRecords(emit, childId);
      case AttendanceSection.summary:
        emit(state.copyWith(
          summarySection: state.summarySection.toLoading(),
        ));
        await _loadSummary(emit, childId);
    }
  }

  Future<void> _loadAll(Emitter<AttendanceState> emit, String childId) async {
    emit(state.copyWith(
      recordsSection: state.recordsSection.toLoading(),
      summarySection: state.summarySection.toLoading(),
    ));

    await Future.wait([
      _loadRecords(emit, childId),
      _loadSummary(emit, childId),
    ]);
  }

  Future<void> _loadRecords(
    Emitter<AttendanceState> emit,
    String childId,
  ) async {
    try {
      final records = await _repository.getAttendance(childId);
      emit(state.copyWith(
        recordsSection: AttendanceAsyncSection.loaded(records),
      ));
    } catch (e) {
      emit(state.copyWith(
        recordsSection: AttendanceAsyncSection.failure(e.toString()),
      ));
      emitPresentation(
        AttendanceFailurePresentationEvent(message: e.toString()),
      );
    }
  }

  Future<void> _loadSummary(
    Emitter<AttendanceState> emit,
    String childId,
  ) async {
    try {
      final summary = await _repository.getAttendanceSummary(childId);
      emit(state.copyWith(
        summarySection: AttendanceAsyncSection.loaded(summary),
      ));
    } catch (e) {
      emit(state.copyWith(
        summarySection: AttendanceAsyncSection.failure(e.toString()),
      ));
      emitPresentation(
        AttendanceFailurePresentationEvent(message: e.toString()),
      );
    }
  }
}
