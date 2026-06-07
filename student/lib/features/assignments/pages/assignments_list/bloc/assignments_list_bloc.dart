import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'assignments_list_event.dart';
part 'assignments_list_state.dart';

sealed class AssignmentsListPresentationEvent {
  const AssignmentsListPresentationEvent();
}

final class AssignmentsListNavigateToDetail
    extends AssignmentsListPresentationEvent {
  final String assignmentId;
  const AssignmentsListNavigateToDetail(this.assignmentId);
}

final class AssignmentsListBloc
    extends Bloc<AssignmentsListEvent, AssignmentsListState>
    with
        BlocPresentationMixin<
          AssignmentsListState,
          AssignmentsListPresentationEvent
        > {
  AssignmentsListBloc({
    required this.assignmentRepository,
    required this.analyticsService,
  }) : super(AssignmentsListState.initial) {
    on<AssignmentsListLoadEvent>(_onLoad);
    on<AssignmentsListRefreshEvent>(_onRefresh);
  }

  final AssignmentRepository assignmentRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    AssignmentsListLoadEvent event,
    Emitter<AssignmentsListState> emit,
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
    AssignmentsListRefreshEvent event,
    Emitter<AssignmentsListState> emit,
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
