import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

sealed class AttendancePresentationEvent {
  const AttendancePresentationEvent();
}

/// Classifies failures so the UI can show contextual copy.
enum AttendanceFailureKind {
  unknown,
  network,
  notFound,
  unauthorized,
}

final class AttendanceFailurePresentationEvent
    extends AttendancePresentationEvent {
  final AttendanceFailureKind kind;
  final String? rawMessage;
  const AttendanceFailurePresentationEvent({
    required this.kind,
    this.rawMessage,
  });
}

final class AttendanceUnauthorizedPresentationEvent
    extends AttendancePresentationEvent {
  const AttendanceUnauthorizedPresentationEvent();
}

/// Drives the parent attendance-monitor screen.
final class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState>
    with BlocPresentationMixin<AttendanceState, AttendancePresentationEvent> {
  final ParentAttendanceRepository _repository;

  AttendanceBloc({required ParentAttendanceRepository repository})
    : _repository = repository,
      super(AttendanceState.initial()) {
    on<AttendanceStarted>(_onStarted);
    on<AttendanceRefreshRequested>(
      _onRefreshRequested,
      transformer: droppable(),
    );
    on<AttendanceRetrySectionRequested>(_onRetrySection);
  }

  Future<void> _onStarted(
    AttendanceStarted event,
    Emitter<AttendanceState> emit,
  ) async {
    if (state.childId == event.childId &&
        (state.recordsSection.isLoaded || state.recordsSection.isLoading)) {
      return;
    }
    emit(state.copyWith(childId: event.childId));
    await _loadAll(emit, event.childId);
  }

  Future<void> _onRefreshRequested(
    AttendanceRefreshRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    if (state.isRefreshing) return;
    emit(state.copyWith(isRefreshing: true, childId: event.childId));
    try {
      await _loadAll(emit, event.childId);
    } finally {
      if (!emit.isDone) {
        emit(state.copyWith(isRefreshing: false));
      }
    }
  }

  Future<void> _onRetrySection(
    AttendanceRetrySectionRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    final childId = state.childId;
    if (childId == null) return;

    switch (event.section) {
      case AttendanceSection.records:
        emit(
          state.copyWith(
            recordsSection: state.recordsSection.toLoading(),
          ),
        );
        await _loadRecords(emit, childId);
      case AttendanceSection.summary:
        emit(
          state.copyWith(
            summarySection: state.summarySection.toLoading(),
          ),
        );
        await _loadSummary(emit, childId);
    }
  }

  Future<void> _loadAll(Emitter<AttendanceState> emit, String childId) async {
    emit(
      state.copyWith(
        recordsSection: state.recordsSection.toLoading(),
        summarySection: state.summarySection.toLoading(),
      ),
    );

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
      if (emit.isDone) return;
      emit(
        state.copyWith(
          recordsSection: AttendanceAsyncSection.loaded(records),
        ),
      );
    } catch (e) {
      if (emit.isDone) return;
      emit(
        state.copyWith(
          recordsSection: AttendanceAsyncSection.failure(_describe(e)),
        ),
      );
      _emitFailure(e);
    }
  }

  Future<void> _loadSummary(
    Emitter<AttendanceState> emit,
    String childId,
  ) async {
    try {
      final summary = await _repository.getAttendanceSummary(childId);
      if (emit.isDone) return;
      emit(
        state.copyWith(
          summarySection: AttendanceAsyncSection.loaded(summary),
        ),
      );
    } catch (e) {
      if (emit.isDone) return;
      emit(
        state.copyWith(
          summarySection: AttendanceAsyncSection.failure(_describe(e)),
        ),
      );
      // Summary failure is non-critical — don't toast.
      _maybeEmitUnauthorized(e);
    }
  }

  // ───────────────────────────────────────────────────────────────────────
  // Helpers
  // ───────────────────────────────────────────────────────────────────────

  void _emitFailure(Object error) {
    _maybeEmitUnauthorized(error);
    emitPresentation(
      AttendanceFailurePresentationEvent(
        kind: _classifyFailure(error),
        rawMessage: _describe(error),
      ),
    );
  }

  String _describe(Object error) {
    if (error is MentorXException) {
      return error.message ?? error.toString();
    }
    if (error is HttpClientResponse) {
      return error.exception?.message ?? 'Request failed (${error.statusCode})';
    }
    return error.toString();
  }

  AttendanceFailureKind _classifyFailure(Object error) {
    if (error is HttpClientResponse) {
      return switch (error.statusCode) {
        401 || 403 => AttendanceFailureKind.unauthorized,
        404 => AttendanceFailureKind.notFound,
        _ => AttendanceFailureKind.unknown,
      };
    }
    return AttendanceFailureKind.unknown;
  }

  void _maybeEmitUnauthorized(Object error) {
    if (error is HttpClientResponse &&
        (error.statusCode == 401 || error.statusCode == 403)) {
      emitPresentation(const AttendanceUnauthorizedPresentationEvent());
    }
  }
}
