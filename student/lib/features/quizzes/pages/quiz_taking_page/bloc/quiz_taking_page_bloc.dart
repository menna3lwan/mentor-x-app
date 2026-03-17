import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'quiz_taking_page_event.dart';
part 'quiz_taking_page_state.dart';

sealed class QuizTakingPagePresentationEvent {
  const QuizTakingPagePresentationEvent();
}

final class QuizTakingPageNavigateBack extends QuizTakingPagePresentationEvent {
  const QuizTakingPageNavigateBack();
}

final class QuizTakingPageBloc
    extends Bloc<QuizTakingPageEvent, QuizTakingPageState>
    with
        BlocPresentationMixin<
          QuizTakingPageState,
          QuizTakingPagePresentationEvent
        > {
  QuizTakingPageBloc({required this.quizRepository})
    : super(QuizTakingPageState.initial) {
    on<QuizTakingPageLoadEvent>(_onLoad);
  }

  final QuizRepository quizRepository;

  Future<void> _onLoad(
    QuizTakingPageLoadEvent event,
    Emitter<QuizTakingPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
