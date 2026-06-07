import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'quiz_list_event.dart';
part 'quiz_list_state.dart';

sealed class QuizListPresentationEvent {
  const QuizListPresentationEvent();
}

final class QuizListNavigateBack extends QuizListPresentationEvent {
  const QuizListNavigateBack();
}

final class QuizListBloc extends Bloc<QuizListEvent, QuizListState>
    with
        BlocPresentationMixin<
          QuizListState,
          QuizListPresentationEvent
        > {
  QuizListBloc({
    required this.quizRepository,
    required this.analyticsService,
  }) : super(QuizListState.initial) {
    on<QuizListLoadEvent>(_onLoad);
  }

  final QuizRepository quizRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    QuizListLoadEvent event,
    Emitter<QuizListState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    analyticsService.logEvent(name: AnalyticsEvents.quizListViewed);
    try {
      final quizzes = await quizRepository.getQuizzes();
      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          quizzes: quizzes,
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
