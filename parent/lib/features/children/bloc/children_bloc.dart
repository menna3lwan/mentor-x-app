import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'children_event.dart';
part 'children_state.dart';

class ChildrenBloc extends Bloc<ChildrenEvent, ChildrenState> {
  final ParentChildrenRepository _childrenRepository;

  ChildrenBloc({
    required ParentChildrenRepository childrenRepository,
  })  : _childrenRepository = childrenRepository,
        super(const ChildrenState()) {
    on<ChildrenStarted>(_onStarted);
    on<ChildrenLookupRequested>(_onLookupRequested);
    on<ChildLinkConfirmed>(_onChildLinkConfirmed);
  }

  Future<void> _onStarted(ChildrenStarted event, Emitter<ChildrenState> emit) async {
    emit(state.copyWith(status: ChildrenStatus.loading));
    try {
      final children = await _childrenRepository.getChildren();
      emit(state.copyWith(status: ChildrenStatus.success, children: children));
    } catch (e) {
      emit(state.copyWith(status: ChildrenStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> _onLookupRequested(
      ChildrenLookupRequested event, Emitter<ChildrenState> emit) async {
    emit(state.copyWith(status: ChildrenStatus.loading));
    try {
      final student = await _childrenRepository.findStudentByChildQuery(
        query: event.query,
      );
      emit(state.copyWith(
        status: ChildrenStatus.success,
        lookedUpStudent: student,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ChildrenStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onChildLinkConfirmed(
      ChildLinkConfirmed event, Emitter<ChildrenState> emit) async {
    emit(state.copyWith(status: ChildrenStatus.loading));
    try {
      await _childrenRepository.linkChild(
        studentId: event.studentId,
        relationship: event.relationship,
      );
      final children = await _childrenRepository.getChildren();
      emit(state.copyWith(
        status: ChildrenStatus.success,
        children: children,
        lookedUpStudent: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ChildrenStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
