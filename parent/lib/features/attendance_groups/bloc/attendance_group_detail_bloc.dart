import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_core/mentorx_core.dart';

import '../../../core/blocs/bloc_error_helpers.dart';

part 'attendance_group_detail_event.dart';
part 'attendance_group_detail_state.dart';

// ──── Presentation events ──────────────────────────────────────────────────

sealed class AttendanceGroupDetailPresentationEvent {
  const AttendanceGroupDetailPresentationEvent();
}

final class AttendanceGroupDetailFailurePresentationEvent
    extends AttendanceGroupDetailPresentationEvent {
  final String message;
  const AttendanceGroupDetailFailurePresentationEvent({
    required this.message,
  });
}

final class AttendanceGroupDetailNotFoundPresentationEvent
    extends AttendanceGroupDetailPresentationEvent {
  const AttendanceGroupDetailNotFoundPresentationEvent();
}

final class AttendanceGroupDetailUnauthorizedPresentationEvent
    extends AttendanceGroupDetailPresentationEvent {
  const AttendanceGroupDetailUnauthorizedPresentationEvent();
}

// ──── Bloc ─────────────────────────────────────────────────────────────────

final class AttendanceGroupDetailBloc
    extends Bloc<AttendanceGroupDetailEvent, AttendanceGroupDetailState>
    with
        BlocPresentationMixin<
          AttendanceGroupDetailState,
          AttendanceGroupDetailPresentationEvent
        > {
  final ParentAttendanceGroupsRepository _repository;

  AttendanceGroupDetailBloc({
    required ParentAttendanceGroupsRepository repository,
  }) : _repository = repository,
       super(AttendanceGroupDetailState.initial()) {
    on<AttendanceGroupDetailStarted>(_onStarted);
    on<AttendanceGroupDetailRefreshRequested>(
      _onRefreshRequested,
      transformer: droppable(),
    );
  }

  Future<void> _onStarted(
    AttendanceGroupDetailStarted event,
    Emitter<AttendanceGroupDetailState> emit,
  ) async {
    emit(
      state.copyWith(
        childId: event.childId,
        groupId: event.groupId,
        status: AttendanceGroupDetailStatus.loading,
      ),
    );
    await _load(emit, event.childId, event.groupId);
  }

  Future<void> _onRefreshRequested(
    AttendanceGroupDetailRefreshRequested event,
    Emitter<AttendanceGroupDetailState> emit,
  ) async {
    final childId = state.childId;
    final groupId = state.groupId;
    if (childId == null || groupId == null) return;
    if (state.isRefreshing) return;
    emit(state.copyWith(isRefreshing: true));
    try {
      await _load(emit, childId, groupId);
    } finally {
      if (!emit.isDone) emit(state.copyWith(isRefreshing: false));
    }
  }

  Future<void> _load(
    Emitter<AttendanceGroupDetailState> emit,
    String childId,
    String groupId,
  ) async {
    try {
      final detail = await _repository.getGroup(
        childId: childId,
        groupId: groupId,
      );
      if (emit.isDone) return;
      emit(
        state.copyWith(
          status: AttendanceGroupDetailStatus.loaded,
          detail: detail,
        ),
      );
    } catch (e) {
      if (emit.isDone) return;
      final message = e.describeError();
      emit(
        state.copyWith(
          status: AttendanceGroupDetailStatus.failure,
          errorMessage: message,
        ),
      );
      if (isUnauthorizedError(e)) {
        emitPresentation(
          const AttendanceGroupDetailUnauthorizedPresentationEvent(),
        );
        return;
      }
      if (e is ParentAttendanceGroupsRepositoryException &&
          e.code == ParentAttendanceGroupsRepositoryExceptionCode.notFound) {
        emitPresentation(
          const AttendanceGroupDetailNotFoundPresentationEvent(),
        );
        return;
      }
      emitPresentation(
        AttendanceGroupDetailFailurePresentationEvent(message: message),
      );
    }
  }
}
