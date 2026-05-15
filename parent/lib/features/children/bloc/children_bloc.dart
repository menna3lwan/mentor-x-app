import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_core/mentorx_core.dart';

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
  const ChildrenFailurePresentationEvent({required this.message});
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
    on<ChildrenRefreshRequested>(_onRefreshRequested);
    on<ChildrenLookupRequested>(_onLookupRequested);
    on<ChildrenLookupCleared>(_onLookupCleared);
    on<ChildLinkConfirmed>(_onLinkConfirmed);
    on<ChildUnlinkRequested>(_onUnlinkRequested);
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
      emit(state.copyWith(
        childrenSection: ChildrenAsyncSection.loaded(children),
      ));
    } catch (e) {
      emit(state.copyWith(
        childrenSection: ChildrenAsyncSection.failure(e.toString()),
      ));
      emitPresentation(
        ChildrenFailurePresentationEvent(message: e.toString()),
      );
    }
  }

  Future<void> _onLookupRequested(
    ChildrenLookupRequested event,
    Emitter<ChildrenState> emit,
  ) async {
    final trimmed = event.query.trim();
    if (trimmed.isEmpty) return;

    emit(state.copyWith(
      lookupSection: state.lookupSection.toLoading(),
    ));
    try {
      final student = await _childrenRepository.findStudentByChildQuery(
        query: trimmed,
      );
      emit(state.copyWith(
        lookupSection: ChildrenAsyncSection.loaded(student),
      ));
    } catch (e) {
      emit(state.copyWith(
        lookupSection: ChildrenAsyncSection.failure(e.toString()),
      ));
      emitPresentation(
        ChildrenFailurePresentationEvent(message: e.toString()),
      );
    }
  }

  void _onLookupCleared(
    ChildrenLookupCleared event,
    Emitter<ChildrenState> emit,
  ) {
    emit(state.copyWith(
      lookupSection: const ChildrenAsyncSection.initial(),
    ));
  }

  Future<void> _onLinkConfirmed(
    ChildLinkConfirmed event,
    Emitter<ChildrenState> emit,
  ) async {
    emit(state.copyWith(linkSection: state.linkSection.toLoading()));
    try {
      final child = await _childrenRepository.linkChild(
        studentId: event.studentId,
        relationship: event.relationship,
      );
      emit(state.copyWith(
        linkSection: ChildrenAsyncSection.loaded(child),
        lookupSection: const ChildrenAsyncSection.initial(),
      ));
      // Refresh the list in the background so the new child shows up next time
      // the management screen is opened.
      await _loadChildren(emit);
      emitPresentation(const ChildLinkSucceededPresentationEvent());
    } catch (e) {
      emit(state.copyWith(
        linkSection: ChildrenAsyncSection.failure(e.toString()),
      ));
      emitPresentation(
        ChildrenFailurePresentationEvent(message: e.toString()),
      );
    }
  }

  Future<void> _onUnlinkRequested(
    ChildUnlinkRequested event,
    Emitter<ChildrenState> emit,
  ) async {
    emit(state.copyWith(
      unlinkingChildId: event.childId,
      unlinkSection: state.unlinkSection.toLoading(),
    ));
    try {
      await _childrenRepository.unlinkChild(event.childId);

      // Optimistically remove from the cached list.
      final updated = state.children
          .where((c) => c.id != event.childId)
          .toList(growable: false);
      emit(state.copyWith(
        unlinkingChildId: null,
        unlinkSection: const ChildrenAsyncSection.loaded(null),
        childrenSection: ChildrenAsyncSection.loaded(updated),
      ));
      emitPresentation(const ChildUnlinkSucceededPresentationEvent());
    } catch (e) {
      emit(state.copyWith(
        unlinkingChildId: null,
        unlinkSection: ChildrenAsyncSection.failure(e.toString()),
      ));
      emitPresentation(
        ChildrenFailurePresentationEvent(message: e.toString()),
      );
    }
  }
}
