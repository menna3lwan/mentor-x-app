import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
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
  AssignmentSubmitPageBloc({
    required this.assignmentRepository,
    required String assignmentId,
  }) : super(AssignmentSubmitPageState(assignmentId: assignmentId)) {
    on<AssignmentSubmitPageLoadEvent>(_onLoad);
    on<AssignmentSubmitPageAnswerSelected>(_onAnswerSelected);
    on<AssignmentSubmitPageNextQuestion>(_onNextQuestion);
    on<AssignmentSubmitPagePreviousQuestion>(_onPreviousQuestion);
    on<AssignmentSubmitPageFileAdded>(_onFileAdded);
    on<AssignmentSubmitPageFileRemoved>(_onFileRemoved);
    on<AssignmentSubmitPageContentChanged>(_onContentChanged);
    on<AssignmentSubmitPageSubmit>(_onSubmit);
  }

  final AssignmentRepository assignmentRepository;

  void _onFileAdded(
    AssignmentSubmitPageFileAdded event,
    Emitter<AssignmentSubmitPageState> emit,
  ) {
    final newPaths = List<String>.from(state.filePaths)..add(event.filePath);
    emit(state.copyWith(filePaths: newPaths));
  }

  void _onFileRemoved(
    AssignmentSubmitPageFileRemoved event,
    Emitter<AssignmentSubmitPageState> emit,
  ) {
    final newPaths = List<String>.from(state.filePaths)..remove(event.filePath);
    emit(state.copyWith(filePaths: newPaths));
  }

  void _onContentChanged(
    AssignmentSubmitPageContentChanged event,
    Emitter<AssignmentSubmitPageState> emit,
  ) {
    emit(state.copyWith(contentText: event.content));
  }

  Future<void> _onLoad(
    AssignmentSubmitPageLoadEvent event,
    Emitter<AssignmentSubmitPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    try {
      final assignment =
          await assignmentRepository.getAssignment(state.assignmentId);
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
    AssignmentSubmitPageAnswerSelected event,
    Emitter<AssignmentSubmitPageState> emit,
  ) {
    final newAnswers = Map<String, String>.from(state.answers);
    newAnswers[event.questionId] = event.selectedAnswer;
    emit(state.copyWith(answers: newAnswers));
  }

  void _onNextQuestion(
    AssignmentSubmitPageNextQuestion event,
    Emitter<AssignmentSubmitPageState> emit,
  ) {
    if (state.currentQuestionIndex < state.questions.length - 1) {
      emit(state.copyWith(currentQuestionIndex: state.currentQuestionIndex + 1));
    }
  }

  void _onPreviousQuestion(
    AssignmentSubmitPagePreviousQuestion event,
    Emitter<AssignmentSubmitPageState> emit,
  ) {
    if (state.currentQuestionIndex > 0) {
      emit(state.copyWith(currentQuestionIndex: state.currentQuestionIndex - 1));
    }
  }

  Future<void> _onSubmit(
    AssignmentSubmitPageSubmit event,
    Emitter<AssignmentSubmitPageState> emit,
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
