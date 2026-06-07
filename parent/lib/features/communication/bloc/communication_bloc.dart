import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent/core/core.dart';

part 'communication_event.dart';
part 'communication_state.dart';

final class CommunicationBloc extends Bloc<CommunicationEvent, CommunicationState> {
  final ParentCommunicationRepository _repository;
  final AnalyticsService _analyticsService;
  static final MentorXLogger _logger = MentorXLogger('CommunicationBloc');

  CommunicationBloc({
    required ParentCommunicationRepository repository,
    required AnalyticsService analyticsService,
  })  : _repository = repository,
        _analyticsService = analyticsService,
        super(const CommunicationState()) {
    on<CommunicationStarted>(_onStarted);
    on<CommunicationRefreshRequested>(_onRefreshRequested);
  }

  Future<void> _onStarted(
    CommunicationStarted event,
    Emitter<CommunicationState> emit,
  ) async {
    _logger.info('Started loading communication for childId: ${event.childId}');
    emit(state.copyWith(status: CommunicationStatus.loading));
    try {
      _analyticsService.logEvent(
        name: AnalyticsEvents.communicationViewed,
        parameters: {AnalyticsParams.id: event.childId},
      );
      final results = await Future.wait([
        _repository.getNotifications(event.childId),
        _repository.getAnnouncements(event.childId),
        _repository.getWhatsAppGroups(event.childId),
      ]);
      
      _logger.info('Successfully loaded communication data for childId: ${event.childId}');
      emit(state.copyWith(
        status: CommunicationStatus.success,
        notifications: results[0] as List<NotificationEntity>,
        announcements: results[1] as List<AnnouncementEntity>,
        whatsAppGroups: results[2] as List<WhatsAppGroupEntity>,
      ));
    } catch (e, s) {
      _logger.error('Failed to load communication data for childId: ${event.childId}', e, s);
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
    _logger.info('Refresh requested for childId: ${event.childId}');
    add(CommunicationStarted(event.childId));
  }
}
