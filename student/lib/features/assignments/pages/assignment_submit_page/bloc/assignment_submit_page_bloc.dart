import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:mentorx_student/core/core.dart';

part 'assignment_submit_page_event.dart';
part 'assignment_submit_page_state.dart';

sealed class AssignmentSubmitPagePresentationEvent {
  const AssignmentSubmitPagePresentationEvent();
}

final class AssignmentSubmitPageNavigateBack
    extends AssignmentSubmitPagePresentationEvent {
  const AssignmentSubmitPageNavigateBack();
}

final class AssignmentSubmitPageBloc
    extends Bloc<AssignmentSubmitPageEvent, AssignmentSubmitPageState>
    with
        BlocPresentationMixin<
          AssignmentSubmitPageState,
          AssignmentSubmitPagePresentationEvent
        > {
  AssignmentSubmitPageBloc({required this.assignmentRepository})
    : super(AssignmentSubmitPageState.initial) {
    on<AssignmentSubmitPageLoadEvent>(_onLoad);
  }

  final AssignmentRepository assignmentRepository;

  Future<void> _onLoad(
    AssignmentSubmitPageLoadEvent event,
    Emitter<AssignmentSubmitPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
