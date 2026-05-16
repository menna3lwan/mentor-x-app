import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'quiz_answers_review_page_event.dart';
part 'quiz_answers_review_page_state.dart';

sealed class QuizAnswersReviewPagePresentationEvent {
  const QuizAnswersReviewPagePresentationEvent();
}

final class QuizAnswersReviewPageNavigateBack
    extends QuizAnswersReviewPagePresentationEvent {
  const QuizAnswersReviewPageNavigateBack();
}

final class QuizAnswersReviewPageBloc
    extends Bloc<QuizAnswersReviewPageEvent, QuizAnswersReviewPageState>
    with
        BlocPresentationMixin<
          QuizAnswersReviewPageState,
          QuizAnswersReviewPagePresentationEvent
        > {
  QuizAnswersReviewPageBloc({
    required this.quizRepository,
    required this.analyticsService,
  }) : super(QuizAnswersReviewPageState.initial) {
    on<QuizAnswersReviewPageLoadEvent>(_onLoad);
  }

  final QuizRepository quizRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    QuizAnswersReviewPageLoadEvent event,
    Emitter<QuizAnswersReviewPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    analyticsService.logEvent(name: AnalyticsEvents.quizAnswersReviewViewed);
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
