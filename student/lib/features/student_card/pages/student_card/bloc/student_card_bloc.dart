import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'student_card_event.dart';
part 'student_card_state.dart';

// ──── Presentation events (one-time, not state) ────
sealed class StudentCardPresentationEvent {
  const StudentCardPresentationEvent();
}

final class StudentCardFailurePresentationEvent
    extends StudentCardPresentationEvent {
  final StudentCardRepositoryException exception;
  const StudentCardFailurePresentationEvent({required this.exception});
}

// ──── Bloc ────
final class StudentCardBloc extends Bloc<StudentCardEvent, StudentCardState>
    with BlocPresentationMixin<StudentCardState, StudentCardPresentationEvent> {
  final StudentCardRepository _repository;
  final AnalyticsService _analyticsService;
  final MentorXLogger _logger = MentorXLogger('StudentCardBloc');

  StudentCardBloc({
    required StudentCardRepository repository,
    required AnalyticsService analyticsService,
    StudentCardState initialState = StudentCardState.initial,
  }) : _repository = repository,
       _analyticsService = analyticsService,
       super(initialState) {
    on<StudentCardLoadEvent>(_onLoad);
  }

  Future<void> _onLoad(
    StudentCardLoadEvent event,
    Emitter<StudentCardState> emit,
  ) async {
    try {
      emit(state.copyWith(loadingState: LoadingState.loading));
      final card = await _repository.getMyCard();
      emit(
        state.copyWith(
          card: card,
          loadingState: LoadingState.loaded,
        ),
      );
      _analyticsService.logEvent(name: AnalyticsEvents.studentCardViewed);
    } catch (e, s) {
      _logger.error('Failed to load student card: ', e, s);
      emit(state.copyWith(loadingState: LoadingState.error));
      emitPresentation(
        StudentCardFailurePresentationEvent(
          exception: e is StudentCardRepositoryException
              ? e
              : StudentCardRepositoryException(
                  code: StudentCardRepositoryExceptionCode.unknown,
                  message: e.toString(),
                ),
        ),
      );
    }
  }
}
