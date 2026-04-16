import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../portal_data/portal_data.dart';

part 'communication_event.dart';
part 'communication_state.dart';

final class CommunicationBloc
    extends Bloc<CommunicationEvent, CommunicationState> {
  final ParentPortalRepository _repository;

  CommunicationBloc({required ParentPortalRepository repository})
    : _repository = repository,
      super(const CommunicationState()) {
    on<CommunicationStarted>(_onStarted);
    on<AnnouncementsSearchChanged>(_onSearch);
  }

  Future<void> _onStarted(
    CommunicationStarted event,
    Emitter<CommunicationState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final notifications = await _repository.getNotifications(
        childId: event.childId,
      );
      final announcements = await _repository.getAnnouncements(
        childId: event.childId,
      );
      final groups = await _repository.getWhatsappGroups(
        childId: event.childId,
      );

      emit(
        state.copyWith(
          isLoading: false,
          notifications: notifications,
          announcements: announcements,
          whatsappGroups: groups,
        ),
      );
    } catch (error) {
      emit(state.copyWith(isLoading: false, errorMessage: error.toString()));
    }
  }

  Future<void> _onSearch(
    AnnouncementsSearchChanged event,
    Emitter<CommunicationState> emit,
  ) async {
    emit(state.copyWith(searchQuery: event.query));
    final announcements = await _repository.getAnnouncements(
      search: event.query,
    );
    emit(state.copyWith(announcements: announcements));
  }
}
