import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'assignment_submit_event.dart';
part 'assignment_submit_state.dart';

sealed class AssignmentSubmitPresentationEvent {
  const AssignmentSubmitPresentationEvent();
}

final class AssignmentSubmitNavigateBack
    extends AssignmentSubmitPresentationEvent {
  const AssignmentSubmitNavigateBack();
}

final class AssignmentSubmitBloc
    extends Bloc<AssignmentSubmitEvent, AssignmentSubmitState>
    with
        BlocPresentationMixin<
          AssignmentSubmitState,
          AssignmentSubmitPresentationEvent
        > {
  AssignmentSubmitBloc({
    required this.assignmentRepository,
    required this.analyticsService,
    required String assignmentId,
  }) : super(AssignmentSubmitState(assignmentId: assignmentId)) {
    on<AssignmentSubmitLoadEvent>(_onLoad);
    on<AssignmentSubmitAnswerSelected>(_onAnswerSelected);
    on<AssignmentSubmitNextQuestion>(_onNextQuestion);
    on<AssignmentSubmitPreviousQuestion>(_onPreviousQuestion);
    on<AssignmentSubmitFileAdded>(_onFileAdded);
    on<AssignmentSubmitFileRemoved>(_onFileRemoved);
    on<AssignmentSubmitContentChanged>(_onContentChanged);
    on<AssignmentSubmitSubmit>(_onSubmit);
  }

  final AssignmentRepository assignmentRepository;
  final AnalyticsService analyticsService;

  void _onFileAdded(
    AssignmentSubmitFileAdded event,
    Emitter<AssignmentSubmitState> emit,
  ) {
    final newPaths = List<String>.from(state.filePaths)..add(event.filePath);
    emit(state.copyWith(filePaths: newPaths));
  }

  void _onFileRemoved(
    AssignmentSubmitFileRemoved event,
    Emitter<AssignmentSubmitState> emit,
  ) {
    final newPaths = List<String>.from(state.filePaths)..remove(event.filePath);
    emit(state.copyWith(filePaths: newPaths));
  }

  void _onContentChanged(
    AssignmentSubmitContentChanged event,
    Emitter<AssignmentSubmitState> emit,
  ) {
    emit(state.copyWith(contentText: event.content));
  }

  Future<void> _onLoad(
    AssignmentSubmitLoadEvent event,
    Emitter<AssignmentSubmitState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    try {
      final assignment = await assignmentRepository.getAssignment(
        state.assignmentId,
      );
      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          assignment: assignment,
          questions: assignment.questions,
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

  void _onAnswerSelected(
    AssignmentSubmitAnswerSelected event,
    Emitter<AssignmentSubmitState> emit,
  ) {
    final newAnswers = Map<String, String>.from(state.answers);
    newAnswers[event.questionId] = event.selectedAnswer;
    emit(state.copyWith(answers: newAnswers));
  }

  void _onNextQuestion(
    AssignmentSubmitNextQuestion event,
    Emitter<AssignmentSubmitState> emit,
  ) {
    if (state.currentQuestionIndex < state.questions.length - 1) {
      emit(
        state.copyWith(currentQuestionIndex: state.currentQuestionIndex + 1),
      );
    }
  }

  void _onPreviousQuestion(
    AssignmentSubmitPreviousQuestion event,
    Emitter<AssignmentSubmitState> emit,
  ) {
    if (state.currentQuestionIndex > 0) {
      emit(
        state.copyWith(currentQuestionIndex: state.currentQuestionIndex - 1),
      );
    }
  }

  Future<void> _onSubmit(
    AssignmentSubmitSubmit event,
    Emitter<AssignmentSubmitState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.actionInProgress));
    try {
      final result = await assignmentRepository.submitAssignment(
        state.assignmentId,
        answers: state.answers,
        filePaths: state.filePaths,
        contentText: state.contentText,
      );
      emit(
        state.copyWith(
          loadingState: LoadingState.success,
          result: result,
        ),
      );
      analyticsService.logEvent(
        name: AnalyticsEvents.assignmentSubmitted,
        parameters: {
          AnalyticsParams.assignmentId: state.assignmentId,
        },
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
