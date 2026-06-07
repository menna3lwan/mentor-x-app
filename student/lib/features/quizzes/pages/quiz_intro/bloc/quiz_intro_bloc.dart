import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'quiz_intro_event.dart';
part 'quiz_intro_state.dart';

sealed class QuizIntroPresentationEvent {
  const QuizIntroPresentationEvent();
}

final class QuizIntroNavigateBack extends QuizIntroPresentationEvent {
  const QuizIntroNavigateBack();
}

final class QuizIntroBloc
    extends Bloc<QuizIntroEvent, QuizIntroState>
    with
        BlocPresentationMixin<
          QuizIntroState,
          QuizIntroPresentationEvent
        > {
  static final MentorXLogger _logger = MentorXLogger('QuizIntroBloc');

  QuizIntroBloc({
    required this.quizRepository,
    required this.profileRepository,
    required this.analyticsService,
    required String quizId,
  }) : super(QuizIntroState(quizId: quizId)) {
    on<QuizIntroLoadEvent>(_onLoad);
  }

  final QuizRepository quizRepository;
  final ProfileRepository profileRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    QuizIntroLoadEvent event,
    Emitter<QuizIntroState> emit,
  ) async {
    _logger.info('_onLoad entered');
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
        _logger.warning('Failed to fetch profile/activeAttempt', e);
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

      _logger.info('_onLoad success: loaded quiz: ${quiz.title}');
      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          quiz: quiz,
          activeAttempt: activeAttempt,
        ),
      );
    } catch (e, s) {
      _logger.error('_onLoad error', e, s);
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
