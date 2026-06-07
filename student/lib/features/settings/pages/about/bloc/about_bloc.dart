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
  static final MentorXLogger _logger = MentorXLogger('AboutBloc');

  AboutBloc() : super(AboutState.initial) {
    on<AboutLoadEvent>(_onLoad);
  }

  Future<void> _onLoad(
    AboutLoadEvent event,
    Emitter<AboutState> emit,
  ) async {
    _logger.info('Handling AboutLoadEvent');
    emit(state.copyWith(loadingState: LoadingState.loading));
    try {
      emit(state.copyWith(loadingState: LoadingState.loaded));
      _logger.info('AboutLoadEvent successfully handled');
    } catch (e, s) {
      _logger.error('Failed handling AboutLoadEvent', e, s);
      emit(state.copyWith(loadingState: LoadingState.error));
    }
  }
}
