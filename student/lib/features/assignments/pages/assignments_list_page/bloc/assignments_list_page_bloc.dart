import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'assignments_list_page_event.dart';
part 'assignments_list_page_state.dart';

sealed class AssignmentsListPagePresentationEvent {
  const AssignmentsListPagePresentationEvent();
}

final class AssignmentsListPageNavigateToDetail
    extends AssignmentsListPagePresentationEvent {
  final String assignmentId;
  const AssignmentsListPageNavigateToDetail(this.assignmentId);
}

final class AssignmentsListPageBloc
    extends Bloc<AssignmentsListPageEvent, AssignmentsListPageState>
    with
        BlocPresentationMixin<
          AssignmentsListPageState,
          AssignmentsListPagePresentationEvent
        > {
  AssignmentsListPageBloc({
    required this.assignmentRepository,
    required this.analyticsService,
  }) : super(AssignmentsListPageState.initial) {
    on<AssignmentsListPageLoadEvent>(_onLoad);
    on<AssignmentsListPageRefreshEvent>(_onRefresh);
  }

  final AssignmentRepository assignmentRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    AssignmentsListPageLoadEvent event,
    Emitter<AssignmentsListPageState> emit,
  ) async {
    emit(
      state.copyWith(loadingState: LoadingState.loading, errorMessage: null),
    );
    try {
      final assignments = await assignmentRepository.getAssignments();
      analyticsService.logEvent(name: AnalyticsEvents.assignmentsListViewed);
      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          assignments: assignments,
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

  Future<void> _onRefresh(
    AssignmentsListPageRefreshEvent event,
    Emitter<AssignmentsListPageState> emit,
  ) async {
    try {
      final assignments = await assignmentRepository.getAssignments();
      emit(
        state.copyWith(
          assignments: assignments,
        ),
      );
    } catch (e) {
      // Keep existing data on refresh error
    }
  }
}
