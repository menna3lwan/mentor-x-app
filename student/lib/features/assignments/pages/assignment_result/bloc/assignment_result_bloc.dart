import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'assignment_result_event.dart';
part 'assignment_result_state.dart';

sealed class AssignmentResultPresentationEvent {
  const AssignmentResultPresentationEvent();
}

final class AssignmentResultNavigateBack
    extends AssignmentResultPresentationEvent {
  const AssignmentResultNavigateBack();
}

final class AssignmentResultBloc
    extends Bloc<AssignmentResultEvent, AssignmentResultState>
    with
        BlocPresentationMixin<
          AssignmentResultState,
          AssignmentResultPresentationEvent
        > {
  static final MentorXLogger _logger = MentorXLogger('AssignmentResultBloc');

  AssignmentResultBloc({
    required this.assignmentRepository,
    required this.analyticsService,
    required String assignmentId,
  }) : super(AssignmentResultState(assignmentId: assignmentId)) {
    on<AssignmentResultLoadEvent>(_onLoad);
  }

  final AssignmentRepository assignmentRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    AssignmentResultLoadEvent event,
    Emitter<AssignmentResultState> emit,
  ) async {
    _logger.info('Handling AssignmentResultLoadEvent for assignment: ${state.assignmentId}');
    emit(state.copyWith(loadingState: LoadingState.loading));
    try {
      final submission = await assignmentRepository.getSubmission(
        state.assignmentId,
      );
      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          submission: submission,
        ),
      );
      analyticsService.logEvent(
        name: AnalyticsEvents.assignmentResultViewed,
        parameters: {
          AnalyticsParams.assignmentId: state.assignmentId,
        },
      );
      _logger.info('Successfully loaded assignment result');
    } catch (e, s) {
      _logger.error('Failed to load assignment result', e, s);
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
