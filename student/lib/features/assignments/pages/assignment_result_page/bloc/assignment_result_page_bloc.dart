import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:mentorx_student/core/core.dart';

part 'assignment_result_page_event.dart';
part 'assignment_result_page_state.dart';

sealed class AssignmentResultPagePresentationEvent {
  const AssignmentResultPagePresentationEvent();
}

final class AssignmentResultPageNavigateBack
    extends AssignmentResultPagePresentationEvent {
  const AssignmentResultPageNavigateBack();
}

final class AssignmentResultPageBloc
    extends Bloc<AssignmentResultPageEvent, AssignmentResultPageState>
    with
        BlocPresentationMixin<
          AssignmentResultPageState,
          AssignmentResultPagePresentationEvent
        > {
  AssignmentResultPageBloc({required this.assignmentRepository})
    : super(AssignmentResultPageState.initial) {
    on<AssignmentResultPageLoadEvent>(_onLoad);
  }

  final AssignmentRepository assignmentRepository;

  Future<void> _onLoad(
    AssignmentResultPageLoadEvent event,
    Emitter<AssignmentResultPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
