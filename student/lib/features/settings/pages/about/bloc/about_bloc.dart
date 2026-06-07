import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'about_event.dart';
part 'about_state.dart';

sealed class AboutPresentationEvent {
  const AboutPresentationEvent();
}

final class AboutNavigateBack extends AboutPresentationEvent {
  const AboutNavigateBack();
}

final class AboutBloc extends Bloc<AboutEvent, AboutState>
    with BlocPresentationMixin<AboutState, AboutPresentationEvent> {
  AboutBloc() : super(AboutState.initial) {
    on<AboutLoadEvent>(_onLoad);
  }

  Future<void> _onLoad(
    AboutLoadEvent event,
    Emitter<AboutState> emit,
  ) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    emit(state.copyWith(loadingState: LoadingState.loaded));
  }
}
