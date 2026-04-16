import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../portal_data/portal_data.dart';

part 'children_event.dart';
part 'children_state.dart';

final class ChildrenBloc extends Bloc<ChildrenEvent, ChildrenState> {
  final ParentPortalRepository _repository;

  ChildrenBloc({required ParentPortalRepository repository})
    : _repository = repository,
      super(const ChildrenState()) {
    on<ChildrenStarted>(_onStarted);
    on<ChildrenSwitched>(_onSwitched);
    on<ChildrenLinked>(_onLinked);
    on<ChildrenUnlinked>(_onUnlinked);
  }

  Future<void> _onStarted(
    ChildrenStarted event,
    Emitter<ChildrenState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final children = await _repository.getChildren();
      emit(
        state.copyWith(
          isLoading: false,
          children: children,
          activeChildId: children.isEmpty ? null : children.first.id,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  void _onSwitched(ChildrenSwitched event, Emitter<ChildrenState> emit) {
    emit(state.copyWith(activeChildId: event.childId));
  }

  Future<void> _onLinked(
    ChildrenLinked event,
    Emitter<ChildrenState> emit,
  ) async {
    emit(state.copyWith(isSaving: true, errorMessage: null));
    try {
      final child = await _repository.linkChild(
        query: event.query,
        relationship: event.relationship,
      );
      final updated = List<ParentChild>.from(state.children)..add(child);
      emit(
        state.copyWith(
          isSaving: false,
          children: updated,
          activeChildId: child.id,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          isSaving: false,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> _onUnlinked(
    ChildrenUnlinked event,
    Emitter<ChildrenState> emit,
  ) async {
    emit(state.copyWith(isSaving: true, errorMessage: null));
    try {
      await _repository.unlinkChild(event.childId);
      final updated = state.children
          .where((item) => item.id != event.childId)
          .toList();
      emit(
        state.copyWith(
          isSaving: false,
          children: updated,
          activeChildId: updated.isEmpty ? null : updated.first.id,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          isSaving: false,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
