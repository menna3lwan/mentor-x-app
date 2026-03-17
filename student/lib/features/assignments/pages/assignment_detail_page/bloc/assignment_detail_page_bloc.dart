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
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
