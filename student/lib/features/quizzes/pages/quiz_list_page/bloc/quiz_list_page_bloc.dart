import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'quiz_list_page_event.dart';
part 'quiz_list_page_state.dart';

sealed class QuizListPagePresentationEvent {
  const QuizListPagePresentationEvent();
}

final class QuizListPageNavigateBack extends QuizListPagePresentationEvent {
  const QuizListPageNavigateBack();
}

final class QuizListPageBloc extends Bloc<QuizListPageEvent, QuizListPageState>
    with
        BlocPresentationMixin<
          QuizListPageState,
          QuizListPagePresentationEvent
        > {
  QuizListPageBloc({required this.quizRepository})
    : super(QuizListPageState.initial) {
    on<QuizListPageLoadEvent>(_onLoad);
  }

  final QuizRepository quizRepository;

  Future<void> _onLoad(
    QuizListPageLoadEvent event,
    Emitter<QuizListPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
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
