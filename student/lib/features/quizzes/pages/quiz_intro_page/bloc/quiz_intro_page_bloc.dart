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
  QuizIntroPageBloc({required this.quizRepository})
    : super(QuizIntroPageState.initial) {
    on<QuizIntroPageLoadEvent>(_onLoad);
  }

  final QuizRepository quizRepository;

  Future<void> _onLoad(
    QuizIntroPageLoadEvent event,
    Emitter<QuizIntroPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
