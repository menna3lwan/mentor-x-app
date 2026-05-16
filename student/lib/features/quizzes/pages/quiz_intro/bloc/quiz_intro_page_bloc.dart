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
    required this.profileRepository,
    required this.analyticsService,
    required String quizId,
  }) : super(QuizIntroPageState(quizId: quizId)) {
    on<QuizIntroPageLoadEvent>(_onLoad);
  }

  final QuizRepository quizRepository;
  final ProfileRepository profileRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    QuizIntroPageLoadEvent event,
    Emitter<QuizIntroPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    try {
      final quiz = await quizRepository.getQuiz(state.quizId);

      QuizAttemptEntity? activeAttempt;
      try {
        final profile = await profileRepository.getProfile();
        activeAttempt = await quizRepository.getStudentAttemptForQuiz(
          profile.id,
          state.quizId,
        );
      } catch (e) {
        // Silently fail attempt fetch if it doesn't exist or profile fails
      }

      analyticsService.logEvent(
        name: AnalyticsEvents.quizIntroViewed,
        parameters: {
          AnalyticsParams.quizId: state.quizId,
          AnalyticsParams.name: quiz.title,
          if (activeAttempt != null)
            'attempt_status': activeAttempt.status.name,
        },
      );

      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          quiz: quiz,
          activeAttempt: activeAttempt,
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
