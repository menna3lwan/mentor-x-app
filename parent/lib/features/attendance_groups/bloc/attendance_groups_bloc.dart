import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_core/mentorx_core.dart';

import '../../../core/blocs/bloc_error_helpers.dart';

part 'attendance_groups_event.dart';
part 'attendance_groups_state.dart';

// ──── Presentation events ──────────────────────────────────────────────────

sealed class AttendanceGroupsPresentationEvent {
  const AttendanceGroupsPresentationEvent();
}

final class AttendanceGroupsFailurePresentationEvent
    extends AttendanceGroupsPresentationEvent {
  final String message;
  const AttendanceGroupsFailurePresentationEvent({required this.message});
}

final class AttendanceGroupsUnauthorizedPresentationEvent
    extends AttendanceGroupsPresentationEvent {
  const AttendanceGroupsUnauthorizedPresentationEvent();
}

// ──── Bloc ─────────────────────────────────────────────────────────────────

/// Drives the attendance-groups list per child.
final class AttendanceGroupsBloc
    extends Bloc<AttendanceGroupsEvent, AttendanceGroupsState>
    with
        BlocPresentationMixin<
          AttendanceGroupsState,
          AttendanceGroupsPresentationEvent
        > {
  final ParentAttendanceGroupsRepository _repository;

  AttendanceGroupsBloc({
    required ParentAttendanceGroupsRepository repository,
  }) : _repository = repository,
       super(AttendanceGroupsState.initial()) {
    on<AttendanceGroupsStarted>(_onStarted);
    on<AttendanceGroupsRefreshRequested>(
      _onRefreshRequested,
      transformer: droppable(),
    );
  }

  Future<void> _onStarted(
    AttendanceGroupsStarted event,
    Emitter<AttendanceGroupsState> emit,
  ) async {
    if (state.childId == event.childId && state.status.isLoaded) return;
    emit(
      state.copyWith(
        childId: event.childId,
        status: AttendanceGroupsStatus.loading,
      ),
    );
    await _load(emit, event.childId);
  }

  Future<void> _onRefreshRequested(
    AttendanceGroupsRefreshRequested event,
    Emitter<AttendanceGroupsState> emit,
  ) async {
    if (state.isRefreshing) return;
    emit(state.copyWith(isRefreshing: true, childId: event.childId));
    try {
      await _load(emit, event.childId);
    } finally {
      if (!emit.isDone) emit(state.copyWith(isRefreshing: false));
    }
  }

  Future<void> _load(
    Emitter<AttendanceGroupsState> emit,
    String childId,
  ) async {
    try {
      final groups = await _repository.getGroups(childId);
      if (emit.isDone) return;
      emit(
        state.copyWith(
          status: AttendanceGroupsStatus.loaded,
          groups: groups,
          errorMessage: null,
        ),
      );
    } catch (e) {
      if (emit.isDone) return;
      final message = e.describeError();
      emit(
        state.copyWith(
          status: AttendanceGroupsStatus.failure,
          errorMessage: message,
        ),
      );
      if (isUnauthorizedError(e)) {
        emitPresentation(
          const AttendanceGroupsUnauthorizedPresentationEvent(),
        );
        return;
      }
      emitPresentation(
        AttendanceGroupsFailurePresentationEvent(message: message),
      );
    }
  }
}
