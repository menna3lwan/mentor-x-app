import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'quiz_review_page_event.dart';
part 'quiz_review_page_state.dart';

sealed class QuizReviewPagePresentationEvent {
  const QuizReviewPagePresentationEvent();
}

final class QuizReviewPageNavigateBack extends QuizReviewPagePresentationEvent {
  const QuizReviewPageNavigateBack();
}

final class QuizReviewPageBloc
    extends Bloc<QuizReviewPageEvent, QuizReviewPageState>
    with
        BlocPresentationMixin<
          QuizReviewPageState,
          QuizReviewPagePresentationEvent
        > {
  QuizReviewPageBloc({
    required this.quizRepository,
    required this.analyticsService,
  }) : super(QuizReviewPageState.initial) {
    on<QuizReviewPageLoadEvent>(_onLoad);
  }

  final QuizRepository quizRepository;
  final AnalyticsService analyticsService;

  Future<void> _onLoad(
    QuizReviewPageLoadEvent event,
    Emitter<QuizReviewPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    analyticsService.logEvent(name: AnalyticsEvents.quizReviewViewed);
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
