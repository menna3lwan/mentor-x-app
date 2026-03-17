import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'quiz_result_page_event.dart';
part 'quiz_result_page_state.dart';

sealed class QuizResultPagePresentationEvent {
  const QuizResultPagePresentationEvent();
}

final class QuizResultPageNavigateBack extends QuizResultPagePresentationEvent {
  const QuizResultPageNavigateBack();
}

final class QuizResultPageBloc
    extends Bloc<QuizResultPageEvent, QuizResultPageState>
    with
        BlocPresentationMixin<
          QuizResultPageState,
          QuizResultPagePresentationEvent
        > {
  QuizResultPageBloc({required this.quizRepository})
    : super(QuizResultPageState.initial) {
    on<QuizResultPageLoadEvent>(_onLoad);
  }

  final QuizRepository quizRepository;

  Future<void> _onLoad(
    QuizResultPageLoadEvent event,
    Emitter<QuizResultPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
