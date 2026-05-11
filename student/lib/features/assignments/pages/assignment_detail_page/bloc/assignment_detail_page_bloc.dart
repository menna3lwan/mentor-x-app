import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'assignment_detail_page_event.dart';
part 'assignment_detail_page_state.dart';

sealed class AssignmentDetailPagePresentationEvent {
  const AssignmentDetailPagePresentationEvent();
}

final class AssignmentDetailPageNavigateBack
    extends AssignmentDetailPagePresentationEvent {
  const AssignmentDetailPageNavigateBack();
}

final class AssignmentDetailPageBloc
    extends Bloc<AssignmentDetailPageEvent, AssignmentDetailPageState>
    with
        BlocPresentationMixin<
          AssignmentDetailPageState,
          AssignmentDetailPagePresentationEvent
        > {
  AssignmentDetailPageBloc({required this.assignmentRepository})
    : super(AssignmentDetailPageState.initial) {
    on<AssignmentDetailPageLoadEvent>(_onLoad);
  }

  final AssignmentRepository assignmentRepository;

  Future<void> _onLoad(
    AssignmentDetailPageLoadEvent event,
    Emitter<AssignmentDetailPageState> emit,
  ) async {
    emit(
      state.copyWith(loadingState: LoadingState.loading, errorMessage: null),
    );
    try {
      final assignment = await assignmentRepository.getAssignment(
        event.assignmentId,
      );
      final submission = await assignmentRepository.getSubmission(
        event.assignmentId,
      );

      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          assignment: assignment,
          submission: submission,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
