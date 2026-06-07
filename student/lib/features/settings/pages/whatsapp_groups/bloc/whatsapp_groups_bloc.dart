import 'package:bloc/bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';

import 'package:mentorx_student/core/core.dart';

part 'whatsapp_groups_event.dart';
part 'whatsapp_groups_state.dart';

sealed class WhatsappGroupsPresentationEvent {
  const WhatsappGroupsPresentationEvent();
}

final class WhatsappGroupsJoinSuccessPresentationEvent
    extends WhatsappGroupsPresentationEvent {
  final String message;

  const WhatsappGroupsJoinSuccessPresentationEvent({required this.message});
}

final class WhatsappGroupsBloc
    extends Bloc<WhatsappGroupsEvent, WhatsappGroupsState>
    with
        BlocPresentationMixin<
          WhatsappGroupsState,
          WhatsappGroupsPresentationEvent
        > {
  static final MentorXLogger _logger = MentorXLogger('WhatsappGroupsBloc');
  final StudentCommunicationRepository _repository;
  final AnalyticsService _analyticsService;

  WhatsappGroupsBloc({
    required StudentCommunicationRepository repository,
    required AnalyticsService analyticsService,
  }) : _repository = repository,
       _analyticsService = analyticsService,
       super(WhatsappGroupsState.initial) {
    on<WhatsappGroupsInitialized>(_onInitialized);
    on<WhatsappGroupsRefreshed>(_onRefreshed);
    on<WhatsappGroupsJoinRequested>(_onJoinRequested);
  }

  Future<void> _onInitialized(
    WhatsappGroupsInitialized event,
    Emitter<WhatsappGroupsState> emit,
  ) async {
    _logger.info('Handling WhatsappGroupsInitialized');
    await _analyticsService.logEvent(
      name: AnalyticsEvents.whatsappGroupsViewed,
    );
    await _load(emit);
  }

  Future<void> _onRefreshed(
    WhatsappGroupsRefreshed event,
    Emitter<WhatsappGroupsState> emit,
  ) async {
    _logger.info('Handling WhatsappGroupsRefreshed');
    await _load(emit);
  }

  Future<void> _onJoinRequested(
    WhatsappGroupsJoinRequested event,
    Emitter<WhatsappGroupsState> emit,
  ) async {
    _logger.info('Handling WhatsappGroupsJoinRequested for group: ${event.groupId}');
    final groupName = state.groups
        .firstWhere(
          (group) => group.id == event.groupId,
          orElse: () => const WhatsappGroupUiModel(
            id: '',
            title: 'Unknown',
            description: '',
            inviteLink: '',
            participantsCount: 0,
            iconUrl: '',
          ),
        )
        .title;

    await _analyticsService.logEvent(
      name: AnalyticsEvents.whatsappGroupJoined,
      parameters: {
        AnalyticsParams.name: groupName,
      },
    );

    emit(state.copyWith(joinedGroupId: event.groupId));
    emitPresentation(
      const WhatsappGroupsJoinSuccessPresentationEvent(
        message:
            'Invite link copied. Open WhatsApp and paste the invite link to join.',
      ),
    );
    _logger.info('Successfully handled join request for group: $groupName');
  }

  Future<void> _load(Emitter<WhatsappGroupsState> emit) async {
    _logger.debug('Loading WhatsApp groups');
    emit(state.copyWith(loadingState: LoadingState.loading));

    try {
      final entities = await _repository.getWhatsAppGroups();

      final groups = entities
          .map(
            (entity) => WhatsappGroupUiModel(
              id: entity.id,
              title: entity.name,
              description: entity.description ?? '',
              inviteLink: entity.url,
              participantsCount: 0, // Not provided by the current entity
              iconUrl: entity.imageUrl,
            ),
          )
          .toList();

      emit(
        state.copyWith(
          loadingState: LoadingState.loaded,
          groups: groups,
        ),
      );
      _logger.info('Successfully loaded ${groups.length} WhatsApp groups');
    } catch (e, s) {
      _logger.error('Failed to load WhatsApp groups', e, s);
      emit(state.copyWith(loadingState: LoadingState.error));
    }
  }
}
