import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_core/mentorx_core.dart';

import '../../../core/blocs/bloc_error_helpers.dart';

part 'children_event.dart';
part 'children_state.dart';

/// Side-effect events emitted by [ChildrenBloc] — toasts / navigation hints.
sealed class ChildrenPresentationEvent {
  const ChildrenPresentationEvent();
}

final class ChildLinkSucceededPresentationEvent
    extends ChildrenPresentationEvent {
  const ChildLinkSucceededPresentationEvent();
}

final class ChildUnlinkSucceededPresentationEvent
    extends ChildrenPresentationEvent {
  const ChildUnlinkSucceededPresentationEvent();
}

final class ChildrenFailurePresentationEvent extends ChildrenPresentationEvent {
  final String message;
  final ChildrenFailureKind kind;
  const ChildrenFailurePresentationEvent({
    required this.message,
    this.kind = ChildrenFailureKind.unknown,
  });
}

/// Classifies failures so the UI can show contextual copy (e.g. "already
/// linked" vs "network down") without parsing strings.
enum ChildrenFailureKind {
  unknown,
  studentNotFound,
  alreadyLinked,
  network,
  unauthorized,
}

/// Fired when the user is no longer authenticated. Wrapper redirects to login.
final class ChildrenUnauthorizedPresentationEvent
    extends ChildrenPresentationEvent {
  const ChildrenUnauthorizedPresentationEvent();
}

/// Drives the parent children-management surface. Maintains three independent
/// async slots: the linked-children list, a one-shot student lookup, and the
/// link / unlink operations. Each loads independently so the UI can show
/// the right state for the right operation.
final class ChildrenBloc extends Bloc<ChildrenEvent, ChildrenState>
    with BlocPresentationMixin<ChildrenState, ChildrenPresentationEvent> {
  final ParentChildrenRepository _childrenRepository;

  ChildrenBloc({required ParentChildrenRepository childrenRepository})
    : _childrenRepository = childrenRepository,
      super(ChildrenState.initial()) {
    on<ChildrenStarted>(_onStarted);
    on<ChildrenRefreshRequested>(
      _onRefreshRequested,
      transformer: droppable(),
    );
    // Lookup is restartable so the latest keystroke wins.
    on<ChildrenLookupRequested>(
      _onLookupRequested,
      transformer: restartable(),
    );
    on<ChildrenLookupCleared>(_onLookupCleared);
    // Mutations are droppable so a double-tap can't double-fire.
    on<ChildLinkConfirmed>(_onLinkConfirmed, transformer: droppable());
    on<ChildUnlinkRequested>(_onUnlinkRequested, transformer: droppable());
  }

  Future<void> _onStarted(
    ChildrenStarted event,
    Emitter<ChildrenState> emit,
  ) async {
    if (!state.childrenSection.isInitial) return;
    await _loadChildren(emit);
  }

  Future<void> _onRefreshRequested(
    ChildrenRefreshRequested event,
    Emitter<ChildrenState> emit,
  ) async {
    await _loadChildren(emit);
  }

  Future<void> _loadChildren(Emitter<ChildrenState> emit) async {
    emit(state.copyWith(childrenSection: state.childrenSection.toLoading()));
    try {
      final children = await _childrenRepository.getChildren();
      emit(
        state.copyWith(
          childrenSection: ChildrenAsyncSection.loaded(children),
        ),
      );
    } catch (e) {
      final message = _describe(e);
      emit(
        state.copyWith(
          childrenSection: ChildrenAsyncSection.failure(message),
        ),
      );
      _maybeEmitUnauthorized(e);
      emitPresentation(
        ChildrenFailurePresentationEvent(
          message: message,
          kind: _classifyFailure(e),
        ),
      );
    }
  }

  Future<void> _onLookupRequested(
    ChildrenLookupRequested event,
    Emitter<ChildrenState> emit,
  ) async {
    final trimmed = event.query.trim();
    if (trimmed.isEmpty) return;

    emit(
      state.copyWith(
        lookupSection: state.lookupSection.toLoading(),
      ),
    );
    try {
      final student = await _childrenRepository.findStudentByChildQuery(
        query: trimmed,
      );
      emit(
        state.copyWith(
          lookupSection: ChildrenAsyncSection.loaded(student),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          lookupSection: ChildrenAsyncSection.failure(_describe(e)),
        ),
      );
      _maybeEmitUnauthorized(e);
      emitPresentation(
        ChildrenFailurePresentationEvent(
          message: _describe(e),
          kind: _classifyFailure(e),
        ),
      );
    }
  }

  void _onLookupCleared(
    ChildrenLookupCleared event,
    Emitter<ChildrenState> emit,
  ) {
    emit(
      state.copyWith(
        lookupSection: const ChildrenAsyncSection.initial(),
      ),
    );
  }

  Future<void> _onLinkConfirmed(
    ChildLinkConfirmed event,
    Emitter<ChildrenState> emit,
  ) async {
    // Guard: don't re-link a child that's already in the list.
    if (state.children.any((c) => c.id == event.studentId)) {
      _failLink(
        emit,
        const ParentChildrenRepositoryException(
          code: ParentChildrenRepositoryExceptionCode.unknown,
          message: 'already linked',
        ),
        ChildrenFailureKind.alreadyLinked,
      );
      return;
    }

    emit(state.copyWith(linkSection: state.linkSection.toLoading()));
    try {
      final child = await _childrenRepository.linkChild(
        studentId: event.studentId,
        relationship: event.relationship,
      );
      emit(
        state.copyWith(
          linkSection: ChildrenAsyncSection.loaded(child),
          lookupSection: const ChildrenAsyncSection.initial(),
        ),
      );
      // Refresh the list in the background so the new child shows up next time
      // the management screen is opened.
      await _loadChildren(emit);
      emitPresentation(const ChildLinkSucceededPresentationEvent());
    } catch (e) {
      _failLink(emit, e, _classifyFailure(e));
    }
  }

  void _failLink(
    Emitter<ChildrenState> emit,
    Object error,
    ChildrenFailureKind kind,
  ) {
    final message = _describe(error);
    emit(
      state.copyWith(
        linkSection: ChildrenAsyncSection.failure(message),
      ),
    );
    _maybeEmitUnauthorized(error);
    emitPresentation(
      ChildrenFailurePresentationEvent(message: message, kind: kind),
    );
  }

  Future<void> _onUnlinkRequested(
    ChildUnlinkRequested event,
    Emitter<ChildrenState> emit,
  ) async {
    // Snapshot the original list before mutating so we can roll back on a
    // failed API call.
    final original = List<ParentChildEntity>.from(state.children);
    final optimisticList = original
        .where((c) => c.id != event.childId)
        .toList(growable: false);

    emit(
      state.copyWith(
        unlinkingChildId: event.childId,
        unlinkSection: state.unlinkSection.toLoading(),
        // Optimistic UI: remove now, restore if the network call fails.
        childrenSection: ChildrenAsyncSection.loaded(optimisticList),
      ),
    );

    try {
      await _childrenRepository.unlinkChild(event.childId);
      emit(
        state.copyWith(
          unlinkingChildId: null,
          unlinkSection: const ChildrenAsyncSection.loaded(null),
        ),
      );
      emitPresentation(const ChildUnlinkSucceededPresentationEvent());
    } catch (e) {
      // Rollback the optimistic remove.
      emit(
        state.copyWith(
          unlinkingChildId: null,
          unlinkSection: ChildrenAsyncSection.failure(_describe(e)),
          childrenSection: ChildrenAsyncSection.loaded(original),
        ),
      );
      _maybeEmitUnauthorized(e);
      emitPresentation(
        ChildrenFailurePresentationEvent(
          message: _describe(e),
          kind: _classifyFailure(e),
        ),
      );
    }
  }

  // ───────────────────────────────────────────────────────────────────────
  // Helpers
  // ───────────────────────────────────────────────────────────────────────

  String _describe(Object error) => error.describeError();

  ChildrenFailureKind _classifyFailure(Object error) {
    // Children repository surfaces failures as both its own
    // `ParentChildrenRepositoryException` (for typed domain errors) and as
    // raw `HttpClientResponse` (for unmapped HTTP errors). Earlier this
    // method also accepted `AuthenticationException`, which only ever
    // travels through the auth flow — that mapping was dead and misleading.
    if (error is ParentChildrenRepositoryException) {
      return switch (error.code) {
        ParentChildrenRepositoryExceptionCode.studentNotFound =>
          ChildrenFailureKind.studentNotFound,
        ParentChildrenRepositoryExceptionCode.unauthorized =>
          ChildrenFailureKind.unauthorized,
        ParentChildrenRepositoryExceptionCode.registrationFailed =>
          ChildrenFailureKind.unknown,
        ParentChildrenRepositoryExceptionCode.fetchError =>
          ChildrenFailureKind.network,
        ParentChildrenRepositoryExceptionCode.unknown =>
          ChildrenFailureKind.unknown,
      };
    }
    if (error is HttpClientResponse) {
      return switch (error.statusCode) {
        401 || 403 => ChildrenFailureKind.unauthorized,
        404 => ChildrenFailureKind.studentNotFound,
        409 => ChildrenFailureKind.alreadyLinked,
        _ => ChildrenFailureKind.unknown,
      };
    }
    return ChildrenFailureKind.unknown;
  }

  void _maybeEmitUnauthorized(Object error) {
    if (isUnauthorizedError(error)) {
      emitPresentation(const ChildrenUnauthorizedPresentationEvent());
    }
  }
}
