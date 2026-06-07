import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'assignment_detail_event.dart';
part 'assignment_detail_state.dart';

sealed class AssignmentDetailPresentationEvent {
  const AssignmentDetailPresentationEvent();
}

final class AssignmentDetailNavigateBack
    extends AssignmentDetailPresentationEvent {
  const AssignmentDetailNavigateBack();
}

final class AssignmentDetailBloc
    extends Bloc<AssignmentDetailEvent, AssignmentDetailState>
    with
        BlocPresentationMixin<
          AssignmentDetailState,
          AssignmentDetailPresentationEvent
        > {
  static final MentorXLogger _logger = MentorXLogger('AssignmentDetailBloc');

  AssignmentDetailBloc({
    required this.assignmentRepository,
    required this.analyticsService,
  }) : super(AssignmentDetailState.initial) {
    on<AssignmentDetailLoadEvent>(_onLoad);
  }

  final AssignmentRepository assignmentRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    AssignmentDetailLoadEvent event,
    Emitter<AssignmentDetailState> emit,
  ) async {
    _logger.info('Handling AssignmentDetailLoadEvent for assignment: ${event.assignmentId}');
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

      analyticsService.logEvent(
        name: AnalyticsEvents.assignmentViewed,
        parameters: {
          AnalyticsParams.assignmentId: event.assignmentId,
          AnalyticsParams.itemName: assignment.title,
        },
      );

      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          assignment: assignment,
          submission: submission,
        ),
      );
      _logger.info('Successfully loaded assignment detail');
    } catch (e, s) {
      _logger.error('Failed to load assignment detail', e, s);
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
