import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'quiz_intro_page_event.dart';
part 'quiz_intro_page_state.dart';

sealed class QuizIntroPagePresentationEvent {
  const QuizIntroPagePresentationEvent();
}

final class QuizIntroPageNavigateBack extends QuizIntroPagePresentationEvent {
  const QuizIntroPageNavigateBack();
}

final class QuizIntroPageBloc
    extends Bloc<QuizIntroPageEvent, QuizIntroPageState>
    with
        BlocPresentationMixin<
          QuizIntroPageState,
          QuizIntroPagePresentationEvent
        > {
  QuizIntroPageBloc({
    required this.quizRepository,
    required this.analyticsService,
    required String quizId,
  }) : super(QuizIntroPageState(quizId: quizId)) {
    on<QuizIntroPageLoadEvent>(_onLoad);
  }

  final QuizRepository quizRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    QuizIntroPageLoadEvent event,
    Emitter<QuizIntroPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    try {
      final quiz = await quizRepository.getQuiz(state.quizId);
      analyticsService.logEvent(
        name: AnalyticsEvents.quizIntroViewed,
        parameters: {
          AnalyticsParams.quizId: state.quizId,
          AnalyticsParams.name: quiz.title,
        },
      );
      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          quiz: quiz,
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
