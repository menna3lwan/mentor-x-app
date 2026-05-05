part of 'assignment_submit_page_bloc.dart';

final class AssignmentSubmitPageState extends Equatable {
  final String assignmentId;
  final LoadingState loadingState;
  final AssignmentEntity? assignment;
  final List<QuizQuestionEntity> questions;
  final int currentQuestionIndex;
  final Map<String, String> answers;
  final AssignmentSubmissionEntity? result;
  final String? errorMessage;

  const AssignmentSubmitPageState({
    required this.assignmentId,
    this.loadingState = LoadingState.initial,
    this.assignment,
    this.questions = const [],
    this.currentQuestionIndex = 0,
    this.answers = const {},
    this.filePaths = const [],
    this.contentText,
    this.result,
    this.errorMessage,
  });

  final List<String> filePaths;
  final String? contentText;

  bool get isLoading => loadingState.isLoading;
  bool get isLoaded => loadingState.isLoaded;
  bool get isSubmitting => loadingState.isActionInProgress;
  bool get isSuccess => loadingState.isSuccess;

  QuizQuestionEntity? get currentQuestion =>
      questions.isNotEmpty ? questions[currentQuestionIndex] : null;

  @override
  List<Object?> get props => [
    assignmentId,
    loadingState,
    assignment,
    questions,
    currentQuestionIndex,
    answers,
    filePaths,
    contentText,
    result,
    errorMessage,
  ];

  AssignmentSubmitPageState copyWith({
    String? assignmentId,
    LoadingState? loadingState,
    AssignmentEntity? assignment,
    List<QuizQuestionEntity>? questions,
    int? currentQuestionIndex,
    Map<String, String>? answers,
    List<String>? filePaths,
    String? contentText,
    AssignmentSubmissionEntity? result,
    String? errorMessage,
  }) {
    return AssignmentSubmitPageState(
      assignmentId: assignmentId ?? this.assignmentId,
      loadingState: loadingState ?? this.loadingState,
      assignment: assignment ?? this.assignment,
      questions: questions ?? this.questions,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      answers: answers ?? this.answers,
      filePaths: filePaths ?? this.filePaths,
      contentText: contentText ?? this.contentText,
      result: result ?? this.result,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
