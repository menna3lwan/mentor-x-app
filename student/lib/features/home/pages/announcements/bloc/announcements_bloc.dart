import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:mentorx_student/core/core.dart';

part 'announcements_event.dart';
part 'announcements_state.dart';

sealed class AnnouncementsPresentationEvent {
  const AnnouncementsPresentationEvent();
}

final class AnnouncementsLoadFailurePresentationEvent extends AnnouncementsPresentationEvent {
  final String message;
  const AnnouncementsLoadFailurePresentationEvent({required this.message});
}

final class AnnouncementsBloc extends Bloc<AnnouncementsEvent, AnnouncementsState>
    with BlocPresentationMixin<AnnouncementsState, AnnouncementsPresentationEvent> {
  static final MentorXLogger _logger = MentorXLogger('AnnouncementsBloc');
  final StudentHomeRepository _homeRepository;

  AnnouncementsBloc({required StudentHomeRepository homeRepository})
      : _homeRepository = homeRepository,
        super(AnnouncementsState.initial) {
    on<AnnouncementsLoadRequested>(_onLoadRequested);
  }

  Future<void> _onLoadRequested(
    AnnouncementsLoadRequested event,
    Emitter<AnnouncementsState> emit,
  ) async {
    _logger.info('Handling AnnouncementsLoadRequested');
    emit(state.copyWith(loadingState: LoadingState.loading, errorMessage: null));
    try {
      final announcements = await _homeRepository.getRecentAnnouncements(size: 20);
      emit(state.copyWith(
        loadingState: LoadingState.loaded,
        announcements: announcements,
      ));
      _logger.info('Successfully loaded ${announcements.length} announcements');
    } catch (e, s) {
      _logger.error('Failed to load announcements', e, s);
      final message = e.toString();
      emit(state.copyWith(
        loadingState: LoadingState.error,
        errorMessage: message,
      ));
      emitPresentation(AnnouncementsLoadFailurePresentationEvent(message: message));
    }
  }
}
