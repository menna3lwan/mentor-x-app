import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'about_page_event.dart';
part 'about_page_state.dart';

sealed class AboutPagePresentationEvent {
  const AboutPagePresentationEvent();
}

final class AboutPageNavigateBack extends AboutPagePresentationEvent {
  const AboutPageNavigateBack();
}

final class AboutPageBloc extends Bloc<AboutPageEvent, AboutPageState>
    with BlocPresentationMixin<AboutPageState, AboutPagePresentationEvent> {
  AboutPageBloc() : super(AboutPageState.initial) {
    on<AboutPageLoadEvent>(_onLoad);
  }

  Future<void> _onLoad(
    AboutPageLoadEvent event,
    Emitter<AboutPageState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
