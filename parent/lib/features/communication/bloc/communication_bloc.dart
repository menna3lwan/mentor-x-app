import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';

part 'communication_event.dart';
part 'communication_state.dart';

class CommunicationBloc extends Bloc<CommunicationEvent, CommunicationState> {
  final ParentCommunicationRepository _repository;

  CommunicationBloc({
    required ParentCommunicationRepository repository,
  })  : _repository = repository,
        super(const CommunicationState()) {
    on<CommunicationStarted>(_onStarted);
    on<CommunicationRefreshRequested>(_onRefreshRequested);
  }

  Future<void> _onStarted(
    CommunicationStarted event,
    Emitter<CommunicationState> emit,
  ) async {
    emit(state.copyWith(status: CommunicationStatus.loading));
    try {
      final results = await Future.wait([
        _repository.getNotifications(event.childId),
        _repository.getAnnouncements(event.childId),
        _repository.getWhatsAppGroups(event.childId),
      ]);
      
      emit(state.copyWith(
        status: CommunicationStatus.success,
        notifications: results[0] as List<NotificationEntity>,
        announcements: results[1] as List<AnnouncementEntity>,
        whatsAppGroups: results[2] as List<WhatsAppGroupEntity>,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CommunicationStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRefreshRequested(
    CommunicationRefreshRequested event,
    Emitter<CommunicationState> emit,
  ) async {
    add(CommunicationStarted(event.childId));
  }
}
